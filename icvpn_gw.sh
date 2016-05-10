#!/bin/sh

CONFDIR="/home/freifunk/config/"
METADIR="/home/freifunk/icvpn/icvpn-meta/"
ICVPNSCRIPTDIR="/home/freifunk/icvpn/icvpn-scripts/"
SCRIPTDIR="/home/freifunk/scripts/"

# update icvpn-meta
cd "${METADIR}"
git pull

# update icvpn-scripts
cd "${ICVPNSCRIPTDIR}"
git pull

# Workaround
chown -R freifunk:freifunk /home/freifunk/icvpn/

# generate dns config
"${ICVPNSCRIPTDIR}"/mkdns -f dnsmasq -x westpfalz > /etc/dnsmasq.d/icvpn.conf
service dnsmasq restart
