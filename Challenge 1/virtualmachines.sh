run(){
    # Informacion del sistema
    CPUS=$(grep -c ^processor /proc/cpuinfo)
    RAM=$(grep MemTotal /proc/meminfo | awk '{printf "%.0f", $2 / 1024}')

    read -p "Nombre de la MV: " vmName
    read -p "Sistema operativo: " oSystem

    read -p "Número de CPUs: " cpus
    isNumber "$cpus"
    isValid "$cpus" "$CPUS"

    read -p "Tamaño de la memoria (MB): " ram
    isNumber "$ram"
    isValid "$ram" "$RAM"

    read -p "Tamaño de la VRAM (MB): " vram
    isNumber "$vram"

    read -p "Tamaño del disco duro virtual (MB): " hdSize
    isNumber "$hdSize"

    read -p "Nombre del controlador SATA: " scName
    read -p "Nombre del controlador IDE: " ideCName
    read -p "Ruta del archivo ISO (por ejemplo, /home/$USER/dvd.iso): " isoPath
    read -p "Nombre de la interfaz de red (por ejemplo, eth0): " netInterface

    createVM
}

#-------------------
# Validaciones

# Valida que la entrada sea un numero
isNumber(){
    if [[ ! "$1" =~ ^[0-9]+$ ]]; then
        echo "El valor $1 no es valido, debe ser un numero"
        exit
    fi
}

#Valida que la entrada sea menor a los recursos totales del sistema
isValid(){
    if [[ "$1" -gt "$2" ]]; then
        echo "El valor $1 excede los recursos disponibles ($2)"
        exit
    fi
}
#--------------------

# Crear la maquina virtual
createVM(){
    # Crear la máquina virtual
    VBoxManage createvm --name "$vmName" --ostype "$oSystem" --register

    # Configurar la VM
    VBoxManage modifyvm "$vmName" --cpus $cpus --memory $ram --vram $vram
    VBoxManage modifyvm "$vmName" --nic1 bridged --bridgeadapter1 "$netInterface"

    # Crear y adjuntar el disco duro virtual
    VBoxManage createhd --filename /home/"$USER"/"$vmName".vdi --size $hdSize --variant Standard
    VBoxManage storagectl "$vmName" --name "$scName" --add sata --bootable on
    VBoxManage storageattach "$vmName" --storagectl "$scName" --port 0 --device 0 --type hdd --medium /home/"$USER"/"$vmName".vdi

    # Crear y adjuntar el controlador IDE y el archivo ISO
    VBoxManage storagectl "$vmName" --name "$ideCName" --add ide
    VBoxManage storageattach "$vmName" --storagectl "$ideCName" --port 0 --device 0 --type dvddrive --medium "$isoPath"

    # Mostrar la información de la VM creada
    VBoxManage showvminfo "$vmName"
}

# Ejecucion del script
run
