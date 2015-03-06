#!/bin/sh

PEERSDIR="/etc/tinc/icvpn/"
BIRDDIR="/etc/bird/"
CONFDIR="/home/freifunk/config/"
METADIR="/home/freifunk/icvpn/meta/"
SCRIPTDIR="/home/freifunk/icvpn/scripts/"

# update tinc peers
cd "${PEERSDIR}"
git pull

# update icvpn-meta
cd "${METADIR}"
git pull

# generate bgp config
# pwd should be meta repo
"${SCRIPTDIR}"/mkbgp -f bird -4 -s . -d bgp_icvpn -x westpfalz > "${BIRDDIR}"/bird_bgp.conf
"${SCRIPTDIR}"/mkbgp -f bird -6 -s . -d bgp_icvpn -x westpfalz > "${BIRDDIR}"/bird6_bgp.conf

cat "${CONFDIR}"/bird_head.conf "${BIRDDIR}"/bird_bgp.conf > "${BIRDDIR}"/bird.conf
cat "${CONFDIR}"/bird6_head.conf "${BIRDDIR}"/bird6_bgp.conf > "${BIRDDIR}"/bird6.conf

birdc configure
birdc6 configure

# generate dns config
# pwd should be meta repo
"${SCRIPTDIR}"/mkdns -f dnsmasq -s . -x westpfalz > /etc/dnsmasq.d/icvpn.conf
/etc/init.d/dnsmasq restart