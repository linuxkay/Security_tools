#!/bin/sh
# created by linuxkay 2011 Sep 4th
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
        arp -an | awk '{print $4}' | sort | uniq -c | grep -v ' 1 ' >> $logpath/arpwatch.log
#for gnome notification notify-send -t 0  "Warning Detected ARP Poisoning" "`cat /home/user/.arpdetect/arpwatch.log`"
        kdialog --passivepopup  "Warning Detected ARP Poisoning" 3
	arp -an | awk '{print $4}' | sort | uniq -c | grep -v ' 1 ' >> $logpath/arpwatchlongterm.log
else
#echo -e "No potential ARP poisoning found" > $logpath/arpwatch.log
echo "No potential ARP poisoning found" > $logpath/arpwatch.log
fi
