#!/bin/sh
# Created by Linuxkay 2011 Sep 4th 
# detect arp poisoning on LAN

currentmonth=`date "+%Y-%m-%d %H:%M:%S"`
logpath="/home/user/.arpdetect"


#rm $logpath/arpwatch.log


echo $currentmonth > $logpath/arpwatch.log
echo -e "-----------------------------------------" > $logpath/arpwatch.log
echo -e >> $logpath/arpwatch.log
arp -an | awk '{print $4}' | sort | uniq -c | grep -v ' 1 '

if [ "$?" -eq 0 ]
then
        arp -an | awk '{print $4}' | sort | uniq -c | grep -v ' 1 ' >> $logpath/arpwatch.log && arp -an | awk '{print $4}' | sort | uniq -c | grep -v ' 1 ' >> $logpath/arpwatchlongterm.log  
	notify-send -t 0  "Warning ARP Poisoning|more details can be found in .arpdetectdir" "`cat /home/user/.arpdetect/arpwatch.log`" -i "/home/user/Pictures/Terminal.png"

else
echo -e "No potential ARP poisoning found" > $logpath/arpwatch.log
fi
