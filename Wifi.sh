#!/bin/bash
if [ -f /etc/modprobe.d/wifi.conf ]
then
   echo "wifi driver installed"
else
   echo "install wifi driver - reboot required"
   cp /usr/local/i3/tools/wifi.conf /etc/modprobe.d/wifi.conf
   sleep 3
fi


# NetworkInfo=$(nmcli nm)
# if [[ $NetworkInfo =~ "disconnected" ]]
# then	
#	nmcli dev wifi connect i3
# fi 

#route add -net 0.0.0.0 gw 192.168.1.1 netmask 0.0.0.0 dev wlan0

# count=$( ping -c 1 192.168.1.1 | grep -i Unreach | wc -l )
# count=$( ssh lbym@192.168.2.1 date | wc -l )
# echo $count
# if [ $count -ne 1 ]

if ping -c 1 192.168.1.1 &> /dev/null
then
  echo wlan0 up
else

  echo restarting wlan0
#  touch /home/lbym/.network_restart.log
  DATE=`date +%Y-%m-%d:%H:%M:%S`
  echo $DATE
  echo $DATE >> /home/lbym/.network_restart.log 

  ifdown wlan0 && ifup --force -v  wlan0
#  wireless-power off
#iwconfig wlan0 essid "i3"

#ifconfig wlan0 down
#ifconfig wlan0 up	
# dhclient wlan0    ; not needed with static IP
fi

cp /usr/local/i3/tools/77-ulogo.rules /etc/udev/rules.d
