#!/bin/bash

TARGET="g.zaunei.net 2003"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

gawk -v interface=eth0 -v prefix=ffwp -v hostname=$(hostname) '/eth0/ { time = systime(); print prefix "." hostname "." interface ".rx.bytes " $2 " " time "\n" prefix "." hostname "." interface ".tx.bytes " $10 " " time "\n" prefix "." hostname "." interface ".rx.packets " $3 " " time "\n" prefix "." hostname "." interface ".tx.packets " $11 " " time "\n" }' /proc/net/dev | nc -q0 $TARGET

gawk -v interface=br-ffwp -v prefix=ffwp -v hostname=$(hostname) '/br-ffwp/ { time = systime(); print prefix "." hostname "." interface ".rx.bytes " $2 " " time "\n" prefix "." hostname "." interface ".tx.bytes " $10 " " time "\n" prefix "." hostname "." interface ".rx.packets " $3 " " time "\n" prefix "." hostname "." interface ".tx.packets " $11 " " time "\n" }' /proc/net/dev | nc -q0 $TARGET

gawk -v interface=ffwp-mesh-vpn -v prefix=ffwp -v hostname=$(hostname) '/ffwp-mesh-vpn/ { time = systime(); print prefix "." hostname "." interface ".rx.bytes " $2 " " time "\n" prefix "." hostname "." interface ".tx.bytes " $10 " " time "\n" prefix "." hostname "." interface ".rx.packets " $3 " " time "\n" prefix "." hostname "." interface ".tx.packets " $11 " " time "\n" }' /proc/net/dev | nc -q0 $TARGET

gawk -v interface=tun0 -v prefix=ffwp -v hostname=$(hostname) '/tun0/ { time = systime(); print prefix "." hostname "." interface ".rx.bytes " $2 " " time "\n" prefix "." hostname "." interface ".tx.bytes " $10 " " time "\n" prefix "." hostname "." interface ".rx.packets " $3 " " time "\n" prefix "." hostname "." interface ".tx.packets " $11 " " time "\n" }' /proc/net/dev | nc -q0 $TARGET

gawk -v interface=icvpn -v prefix=ffwp -v hostname=$(hostname) '/icvpn/ { time = systime(); print prefix "." hostname "." interface ".rx.bytes " $2 " " time "\n" prefix "." hostname "." interface ".tx.bytes " $10 " " time "\n" prefix "." hostname "." interface ".rx.packets " $3 " " time "\n" prefix "." hostname "." interface ".tx.packets " $11 " " time "\n" }' /proc/net/dev | nc -q0 $TARGET

gawk -v interface=bat0 -v prefix=ffwp -v hostname=$(hostname) '/bat0/ { time = systime(); print prefix "." hostname "." interface ".rx.bytes " $2 " " time "\n" prefix "." hostname "." interface ".tx.bytes " $10 " " time "\n" prefix "." hostname "." interface ".rx.packets " $3 " " time "\n" prefix "." hostname "." interface ".tx.packets " $11 " " time "\n" }' /proc/net/dev | nc -q0 $TARGET

gawk -v prefix=ffwp -v hostname=$(hostname) '{ time = systime(); print prefix "." hostname ".load.1 " $1 " " time "\n" prefix "." hostname ".load.5 " $2 " " time "\n" prefix "." hostname ".load.15 " $3 " " time "\n" }' /proc/loadavg | nc -q0 $TARGET

gawk -v prefix=ffwp -v hostname=$(hostname) '{ time = systime(); print prefix "." hostname ".netfilter.conntrack.count " $1 " " time}' /proc/sys/net/ipv4/netfilter/ip_conntrack_count | nc -q0 $TARGET

#/usr/bin/python /root/ff-tools/fastd/fastd-statistics.py -s /var/run/fastd-ffwp.status | gawk -v prefix=ffwp -v hostname=$(hostname) '{ time = systime(); print prefix "." hostname ".fastd-peers " $1 " " time "\n" prefix "." hostname ".fastd-connections " $2 " " time "\n" }' | nc -q0 $TARGET
/usr/bin/python $DIR/fastd-statistics.py -s /var/run/fastd-ffwp.status | gawk -v prefix=ffwp -v hostname=$(hostname) '{ time = systime(); print prefix "." hostname ".fastd-connections " $1 " " time "\n" }' | nc -q0 $TARGET
/usr/bin/python $DIR/dhcp_leases.py | nc -q0 $TARGET
