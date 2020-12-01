# #********************************************************************************************************************
#*      Fichero: E:\psFotos\fotosDuplicadas.ps1                                                   
#*        Autor: Carlos Ruiz                                                                      
#*      Version: 1.0                                                                              
#* Fecha inicio: 27/11/2020                                                                       
#* Fecha modif.:                                                                                  
#*     Objetivo: Lee los diferentes ficheros *.JPG en  $DB y si no está duplicado lo mueve a $DP 
#*               Sí esta duplicado lo mueve renombrado como *-1.JPG                              
#*               Directorio Principal: $DP = "E:\copiaFotosIphoneAll"                            
#*               Directorio Búsqueda:  $DB = "E:\copiaFotosIphoneAll\cop"                        
#**********************************************************************************************************************
#
# ---------------------------------------------------------------------------------------------------------------------
# -   IMPORT MODULES   -
# ---------------------------------------------------------------------------------------------------------------------
#
    Import-Module C:\PS\sAutoDistribucion\LIB\write-Log.psm1
#
# ---------------------------------------------------------------------------------------------------------------------
# ---   PARÁMETROS IN    ---
# ---------------------------------------------------------------------------------------------------------------------
#
# ---------------------------------------------------------------------------------------------------------------------
# --- FUNCTIONS - STARTS ----
# ---------------------------------------------------------------------------------------------------------------------
#
Function generaLista ($dirA,  $lista) {
    $lis = Get-ChildItem "$dirA\IMG_*.JPG"
    foreach ($l in $lis) {
        $l.Name |  Out-File "$lista" -Append
    }
}
#
Function generaNombre ($oldNombre, $dirBus) {
    $sufijo = 1
    $nombreBus = "$dirBus" + $oldNombre.name
    while (Test-Path $nombreBus ) {
        $nombreBus = "$dirBus" + $oldNombre.basename  + "-" + "$sufijo" + $oldNombre.Extension
        $sufijo++
    }
    return $nombreBus
}
#
#----------------------------------------------------------------------------------------------------------------------
#       - VARIABLES - START -
#----------------------------------------------------------------------------------------------------------------------
#
    $logDIR     = "E:\psFotos\fotosDuplicadas\LOG\"
    $LogNamePre = "LOG-fotosDuplicadas-"
    $lPrincipal = "E:\psFotos\fotosDuplicadas\LOG\lPrincipal.txt"
    $lBusqueda  = "E:\psFotos\fotosDuplicadas\LOG\lBusqueda.txt"
    $DP         = "E:\copiaFotosIphoneAll\"                            
    $DB         = "E:\copiaFotosIphoneAll\cop\" 
#
#----------------------------------------------------------------------------------------------------------------------
# - SCRIPT MAIN BODY - START -
#----------------------------------------------------------------------------------------------------------------------
#
    "" |  Out-File "$lPrincipal"
    "" |  Out-File "$lbusqueda"
    generaLista $DP $lPrincipal
    generaLista $DB $lBusqueda
    $files = Get-ChildItem "$DB\IMG_*.JPG"
    foreach ($a in $files) {
        $checkBus = "$DP" + $a.name
        if (Test-Path $checkBus ) { # Existe el fichero en $DP "Renombramos"
            $nombreDefinitivo = generaNombre $a $DP
            Copy-Item $a $nombreDefinitivo
            $texto = "Existe: Renombramos $a.Name en destimo a $nombreDefinitivo" 
            write-log -Text $texto -LogFileDirectory $logDIR -LogFileName $LogNamePre -LogFase "FD" 
        } else {                    # No Existe el fichero en $DP "Movemos"
            Copy-Item $a -Destination $DP    
            $texto = "Movemos $a.Name a destino" 
            write-log -Text $texto -LogFileDirectory $logDIR -LogFileName $LogNamePre -LogFase "FD" 
        }
        Write-Host "Foto: $a.Name"
    }