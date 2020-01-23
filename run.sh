#!/bin/bash
echo "Setting timezone"
TZ=${TZ:-"Etc/UTC"}
rm /etc/localtime
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
dpkg-reconfigure -f noninteractive tzdata
cd /opt/firebird/bin
#service xinetd start
/etc/init.d/xinetd start 
sh
