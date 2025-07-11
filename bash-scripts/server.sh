#!/bin/bash

ping -c 2 192.168.0.2 1> /dev/null

if [ $? -eq 0 ]; then
    echo Maquina  Activa
    thunar sftp://tux@192.168.0.2:63630/home/tux
else
    echo Maquina  Inactiva
fi        

ping -c 2 192.168.0.3 1>  /dev/null
if [ $? -eq 0 ]; then
    echo Maquina2 Activa
    thunar sftp://tux@192.168.0.3:63630/home/tux
else
    echo Maquina2 Inactiva
