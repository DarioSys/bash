#!/bin/bash

# Creo mi directorio chroot
mkdir fake-root

# Instalo debootstrap
apt install debootstrap -y

# Instalo los paquetes en mi directorio chroot
debootstrap bookworm ./fake-root http://deb.debian.org/debian

# Montar los procesos, archivos de sistema, terminales etc
mount -o bind /proc fake-root/proc
mount -o bind /sys  fake-root/sys
mount -o bind /dev  fake-root/dev
mount -o bind /dev/pts fake-root/dev/pts
mount -o bind /run   fake-root/run

# Entrando al chroot 
chroot fake-root


