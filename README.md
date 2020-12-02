# Test-1
Ejemplo PS para mezclar dos directorios para probar GitHub
Lee los archivos de un determinado tipo que especificaremos ej. *.JPG
        $DB         = "E:\copiaFotosIphoneAll\cop\" 
        
Comprueba sí existe fileA.jpg en el directorio destino: 
        $DP         = "E:\copiaFotosIphoneAll\"                            

  Si no existe lo copia al destino con el nombre fileA.jpg
  Si existe en destino añade una secuencia fileA-1.jpg
    si también existe incrementa hasta encontrar un nombre que no exista

Sí descomentamos las líneas:
    ### "" |  Out-File "$lPrincipal"
    ### "" |  Out-File "$lbusqueda"
    Nos generará un fichero con el índice de ficheros en el origen
         $lPrincipal = "E:\psFotos\fotosDuplicadas\LOG\lPrincipal.txt"
    Nos generará un fichero con el índice de ficheros en el destino
        $lBusqueda  = "E:\psFotos\fotosDuplicadas\LOG\lBusqueda.txt"

Nos genera un log estándar en "E:\psFotos\fotosDuplicadas\LOG\"
con el nombre "LOG-fotosDuplicadas-"
    
