#!bin/bash

# Script para eliminar el proceso del kworker que eleba la CPU

grep . -r /sys/firmware/acpi/interrupts/  # Entramos en la opcion de energía

# Configuramos en crontab para que deshabilite cada vez que se inicia

(crontab -l ; echo "@reboot echo 'disable' > /sys/firmware/acpi/interrupts/gpe13") | crontab -

# Creamos un archivo que vamos a copiar en un directorio

touch /etc/pm/sleep.d/30_disable_gpe13

#  Damos permisos de ejecucion 

chmod +x /etc/pm/sleep.d/30_disable_gpe13

#

echo '#!/bin/bash' > /etc/pm/sleep.d/30_disable_gpe13
echo 'case "$1" in' >> /etc/pm/sleep.d/30_disable_gpe13
echo '	thaw|resume)' >> /etc/pm/sleep.d/30_disable_gpe13
echo '    	echo disable > /sys/firmware/acpi/interrupts/gpe13 2>/dev/null' >> /etc/pm/sleep.d/30_disable_gpe13
echo '    	;;' >> /etc/pm/sleep.d/30_disable_gpe13
echo '	*)' >> /etc/pm/sleep.d/30_disable_gpe13
echo '    	;;' >> /etc/pm/sleep.d/30_disable_gpe13
echo 'esac' >> /etc/pm/sleep.d/30_disable_gpe13
echo 'exit $?' >> /etc/pm/sleep.d/30_disable_gpe13

# Damos un mensaje y reiniciamos

echo 'El script se ejecuto con exito, se reiniciará automaticamente para guardar los cambios'

reboot
