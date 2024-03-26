#!/bin/bash
#
# Description : Kio Diekin PS2 Toolkit
# Author      : Supreme Team
# Credit      : Kio Diekin
# Version     : 2.0
#
clear

infobox=""
infobox="${infobox}\n"
infobox="${infobox}Kio Diekin Ps2 Toolkit\n\n"
infobox="${infobox}\n"
infobox="${infobox}This script will let you install or update all *KIO DIEKINS* PS2 Configs.\n"
infobox="${infobox}\n"
infobox="${infobox}This script will also let you add & install the PS2 Emulator (Installer by RapidEdwin08).\n"
infobox="${infobox}\n"
infobox="${infobox}\n\n"

dialog --backtitle "Kio Diekin PS2 Toolkit" \
--title "Kio Diekin PS2 Toolkit" \
--msgbox "${infobox}" 0 0

function main_menu() {
stats_check
    local choice

    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title "Kio Kiekin PS2 Toolkit" \
            --ok-label OK --cancel-label Exit \
            --menu "What action would you like to perform?" 0 0 0 \
            1 "Install/update Kio diekin PS2 Configs ($ps2_configs)" \
            2 "Add & Install the PS2 Emulator (BY RapidEdwin08)($ps2_emulator)" \
            2>&1 > /dev/tty)

        case "$choice" in
            1) start-install-ps2-configs ;;
            2) start-install-ps2-emulator ;;
            *)  break ;;
        esac
    done
}


function start-install-ps2-configs() {
stats_check
if [ $NETCONNECTED  = 1 ]; then
        dialog  --sleep 1 --title "OFFLINE?" --msgbox " 
        Your Offline. Please Connect To The Internet And Try Again! Now Backing Out To Main Menu!" 0 0 
	quit
else

echo -e "$(tput setaf 2)NOW INSTALLING/UPDATING KIO DIEKINS PS2 CONFIGS!$(tput sgr0)"
sleep 3
clear
		
	#Download All
	cd $HOME/
    git clone https://github.com/SupremePi/Kiodiekin_Ps2_Toolkit.git
    cd Kiodiekin_Ps2_Toolkit/
    sudo rsync -av /home/pi/Kiodiekin_Ps2_Toolkit/aethersx2/ /home/pi/.config/aethersx2/

	echo -e "$(tput setaf 2)Done! $(tput sgr0)"
	sudo rm -R /home/pi/Kiodiekin_Ps2_Toolkit
	sleep 3
	clear

fi
}

function start-install-ps2-emulator() {
stats_check
if [ $NETCONNECTED  = 1 ]; then
        dialog  --sleep 1 --title "OFFLINE?" --msgbox " 
        Your Offline. Please Connect To The Internet And Try Again! Now Backing Out To Main Menu!" 0 0 
	quit
else

echo -e "$(tput setaf 2)NOW INSTALLING THE PS2 EMULATOR!$(tput sgr0)"
sleep 3
clear
		
	#Download All
	cd $HOME/
    git clone https://github.com/SupremePi/Kiodiekin_Ps2_Toolkit.git
    cd Kiodiekin_Ps2_Toolkit/
    sudo rsync -av /home/pi/Kiodiekin_Ps2_Toolkit/ext/ /home/pi/RetroPie-Setup/ext/
	cd $HOME/
	sudo bash ./RetroPie-Setup/retropie_packages.sh aethersx2 sources
	
	echo -e "$(tput setaf 2)Done! $(tput sgr0)"
	sudo rm -R /home/pi/Kiodiekin_Ps2_Toolkit
	sleep 3
	clear

fi
}

stats_check() {
if [ -f /home/pi/.config/aethersx2/Kio-diekins-configs.ini ]; then
	ps2_configs=INSTALLED
else
	ps2_configs=MISSING
fi

if [ -d /home/pi/.config/aethersx2 ]; then
	ps2_emulator=INSTALLED
else
	ps2_emulator=MISSING
fi
}

##############
#-CHECK LIST-#
##############

wget -q --spider http://google.com
if [ $? -eq 0 ]; then
  NETCONNECTED=0
else
  NETCONNECTED=1
fi

main_menu
