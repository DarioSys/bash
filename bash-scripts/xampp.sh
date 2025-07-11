#!/bin/bash

echo "                                                                            "
echo " #    #   ##   #    # #####  #####      ####   ####  #####  # #####  ##### "
echo "  #  #   #  #  ##  ## #    # #    #    #      #    # #    # # #    #   #   "
echo "   ##   #    # # ## # #    # #    #     ####  #      #    # # #    #   #   "
echo "   ##   ###### #    # #####  #####          # #      #####  # #####    #   "
echo "  #  #  #    # #    # #      #         #    # #    # #   #  # #        #   "
echo " #    # #    # #    # #      #          ####   ####  #    # # #        #   "
echo "                                                                            "



echo "-------------------------------------------------------------------------------"
echo ""


echo "Seleccione 1. Para iniciar xampp 2. Para Apagar xampp: "
read xampp

if [ $xampp -eq 1 ]; then
	sudo /opt/lampp/lampp start
	echo "XAMPP se ha iniciado con exito"
elif [ $xampp -eq 2 ]; then
	sudo /opt/lampp/lampp stop
	echo "XAMPP se ha apagado con exito"
else
	echo "Para iniciar o  apagar XAMPP, presione 1 o 2"
fi

