# pip install six isc-dhcp-leases
from isc_dhcp_leases.iscdhcpleases import Lease, IscDhcpLeases
import socket
import time

leases = IscDhcpLeases('/var/lib/dhcp/dhcpd.leases')
active_leases = leases.get_current()
print('ffwp.' + socket.gethostname() + '.dhcp.active_leases ' + str(len(active_leases)) + ' ' + str(int(time.time())))
