#!/bin/sh
set -e

IFACES=$(ls /var/lib/vnstat/)

TARGET=/home/freifunk/vnstati/gw03/

for iface in $IFACES; do
    /usr/bin/vnstati -i ${iface} -h -o ${TARGET}${iface}_hourly.png
    /usr/bin/vnstati -i ${iface} -d -o ${TARGET}${iface}_daily.png
    /usr/bin/vnstati -i ${iface} -m -o ${TARGET}${iface}_monthly.png
    /usr/bin/vnstati -i ${iface} -t -o ${TARGET}${iface}_top10.png
    /usr/bin/vnstati -i ${iface} -s -o ${TARGET}${iface}_summary.png
done
rsync -a -e 'ssh -p 42225' /home/freifunk/vnstati/gw03 freifunk@gw01.westpfalz.freifunk.net:/home/freifunk/vnstati
