#!/bin/sh

PEERSDIR="/etc/tinc/icvpn/"
BIRDDIR="/etc/bird/"
CONFDIR="/home/freifunk/config/"
METADIR="/home/freifunk/icvpn/icvpn-meta/"
ICVPNSCRIPTDIR="/home/freifunk/icvpn/icvpn-scripts/"
SCRIPTDIR="/home/freifunk/scripts/"

# ToDo: Befehle lieber mit sudo -u freifunk -H sh -c "BEFEHL"

# update tinc peers
cd "${PEERSDIR}"
git pull

# update icvpn-meta
cd "${METADIR}"
git pull

# update icvpn-scripts
cd "${ICVPNSCRIPTDIR}"
git pull

# Workaround
chown -R freifunk:freifunk /home/freifunk/icvpn/

# generate bgp config
cd "${ICVPNSCRIPTDIR}"
"${ICVPNSCRIPTDIR}"/mkbgp -f bird -4 -d icvpn_tinc -p icvpn_tinc_ -x westpfalz > "${BIRDDIR}"/bird4_peers_icvpn_tinc.conf
"${ICVPNSCRIPTDIR}"/mkbgp -f bird -6 -d icvpn_tinc -p icvpn_tinc_ -x westpfalz> "${BIRDDIR}"/bird6_peers_icvpn_tinc.conf

# generate roa
"${ICVPNSCRIPTDIR}"/mkroa -4 > "${BIRDDIR}"/bird4_roa_icvpn.conf
"${ICVPNSCRIPTDIR}"/mkroa -6 > "${BIRDDIR}"/bird6_roa_icvpn.conf

# reload bird
birdc configure
birdc6 configure
