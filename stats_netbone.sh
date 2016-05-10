#!/bin/bash

TARGET="g.zaunei.net 2003"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

gawk -v interface=eth0 -v prefix=ffwp -v hostname=$(hostname) '/eth0/ { time = systime(); print prefix "." hostname "." interface ".rx.bytes " $2 " " time "\n" prefix "." hostname "." interface ".tx.bytes " $10 " " time "\n" prefix "." hostname "." interface ".rx.packets " $3 " " time "\n" prefix "." hostname "." interface ".tx.packets " $11 " " time "\n" }' /proc/net/dev | nc -q0 $TARGET

gawk -v interface=eth1 -v prefix=ffwp -v hostname=$(hostname) '/eth1/ { time = systime(); print prefix "." hostname "." interface ".rx.bytes " $2 " " time "\n" prefix "." hostname "." interface ".tx.bytes " $10 " " time "\n" prefix "." hostname "." interface ".rx.packets " $3 " " time "\n" prefix "." hostname "." interface ".tx.packets " $11 " " time "\n" }' /proc/net/dev | nc -q0 $TARGET

gawk -v interface=icvpn_tinc -v prefix=ffwp -v hostname=$(hostname) '/icvpn_tinc/ { time = systime(); print prefix "." hostname "." interface ".rx.bytes " $2 " " time "\n" prefix "." hostname "." interface ".tx.bytes " $10 " " time "\n" prefix "." hostname "." interface ".rx.packets " $3 " " time "\n" prefix "." hostname "." interface ".tx.packets " $11 " " time "\n" }' /proc/net/dev | nc -q0 $TARGET

gawk -v interface=ffrl_dus0 -v prefix=ffwp -v hostname=$(hostname) '/ffrl_dus0/ { time = systime(); print prefix "." hostname "." interface ".rx.bytes " $2 " " time "\n" prefix "." hostname "." interface ".tx.bytes " $10 " " time "\n" prefix "." hostname "." interface ".rx.packets " $3 " " time "\n" prefix "." hostname "." interface ".tx.packets " $11 " " time "\n" }' /proc/net/dev | nc -q0 $TARGET
gawk -v interface=ffrl_dus1 -v prefix=ffwp -v hostname=$(hostname) '/ffrl_dus1/ { time = systime(); print prefix "." hostname "." interface ".rx.bytes " $2 " " time "\n" prefix "." hostname "." interface ".tx.bytes " $10 " " time "\n" prefix "." hostname "." interface ".rx.packets " $3 " " time "\n" prefix "." hostname "." interface ".tx.packets " $11 " " time "\n" }' /proc/net/dev | nc -q0 $TARGET
gawk -v interface=ffrl_ber0 -v prefix=ffwp -v hostname=$(hostname) '/ffrl_ber0/ { time = systime(); print prefix "." hostname "." interface ".rx.bytes " $2 " " time "\n" prefix "." hostname "." interface ".tx.bytes " $10 " " time "\n" prefix "." hostname "." interface ".rx.packets " $3 " " time "\n" prefix "." hostname "." interface ".tx.packets " $11 " " time "\n" }' /proc/net/dev | nc -q0 $TARGET
gawk -v interface=ffrl_ber1 -v prefix=ffwp -v hostname=$(hostname) '/ffrl_ber1/ { time = systime(); print prefix "." hostname "." interface ".rx.bytes " $2 " " time "\n" prefix "." hostname "." interface ".tx.bytes " $10 " " time "\n" prefix "." hostname "." interface ".rx.packets " $3 " " time "\n" prefix "." hostname "." interface ".tx.packets " $11 " " time "\n" }' /proc/net/dev | nc -q0 $TARGET
gawk -v interface=ffrl_fra0 -v prefix=ffwp -v hostname=$(hostname) '/ffrl_fra0/ { time = systime(); print prefix "." hostname "." interface ".rx.bytes " $2 " " time "\n" prefix "." hostname "." interface ".tx.bytes " $10 " " time "\n" prefix "." hostname "." interface ".rx.packets " $3 " " time "\n" prefix "." hostname "." interface ".tx.packets " $11 " " time "\n" }' /proc/net/dev | nc -q0 $TARGET
gawk -v interface=ffrl_fra1 -v prefix=ffwp -v hostname=$(hostname) '/ffrl_fra1/ { time = systime(); print prefix "." hostname "." interface ".rx.bytes " $2 " " time "\n" prefix "." hostname "." interface ".tx.bytes " $10 " " time "\n" prefix "." hostname "." interface ".rx.packets " $3 " " time "\n" prefix "." hostname "." interface ".tx.packets " $11 " " time "\n" }' /proc/net/dev | nc -q0 $TARGET


gawk -v prefix=ffwp -v hostname=$(hostname) '{ time = systime(); print prefix "." hostname ".load.1 " $1 " " time "\n" prefix "." hostname ".load.5 " $2 " " time "\n" prefix "." hostname ".load.15 " $3 " " time "\n" }' /proc/loadavg | nc -q0 $TARGET

gawk -v prefix=ffwp -v hostname=$(hostname) '{ time = systime(); print prefix "." hostname ".netfilter.conntrack.count " $1 " " time}' /proc/sys/net/ipv4/netfilter/ip_conntrack_count | nc -q0 $TARGET
