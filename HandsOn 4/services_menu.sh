#!/bin/bash

showMenu(){
    echo "1) Mostrar contenido de un fichero"
    echo "2) Crear un archivo de texto"
    echo "3) Comparar dos archivos"
    echo "4) Buscar cadena de texto en archivo"
    echo "5) Contar el numero de lineas de un archivo de texto"
    echo "0) Salir"
}

readOption(){
    read -p "Seleccione una opcion [0-5]: " option
}

run(){
    case $option in
        1)
            read -p "Escriba la ruta absoluta del fichero: " path
            if [[ -d "$path" ]]; then
                ls "$path"
            else
                echo "El fichero no existe o la ruta es incorrecta"
            fi
        ;;

        2)
            read -p "Escriba la linea de texto que desea agregar al archivo: " string
            echo "$string" > myfile.txt
        ;;

        3)
            read -p "Escriba el nombre del primer archivo: " fFile
            if [[ -f "$fFile" ]]; then
                read -p "Escriba el nombre del segundo archivo: " sFile
                if [[ -f "$sFile" ]]; then
                    diff -y "$fFile" "$sFile"
                else
                    echo "El archivo $sFile no existe o la ruta es incorrecta"
                fi
            else
                echo "El archivo $fFile no existe o la ruta es incorrecta"
            fi
        ;;

        4)
            read -p "Escriba la ruta absoluta de un archivo de texto: " path
            if [[ -f "$path" ]]; then
                read -p "Cadena de texto a buscar en el archivo: " string
                if grep -q "$string" "$path"; then
                    echo "La cadena '$string' se encontró en el archivo."
                else
                    echo "La cadena '$string' no se encontró en el archivo."
                fi
            else
                echo "El archivo no existe o la ruta es incorrecta."
            fi
        ;;

        5)
            read -p "Escriba la ruta absoluta de un archivo de texto: " path
            if [[ -f "$path" ]]; then
                awk 'END { print NR }' "$path"
            else
                echo "El archivo no existe o la ruta es incorrecta."
            fi
        ;;
        0)
            echo "Saliendo" 
            exit
        ;;

        *)
            echo "Opcion invalida"
        ;;
    esac
}

while true; do
    showMenu
    readOption
    run
done
