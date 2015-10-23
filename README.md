# scripts-ffwp
Westpfalz specific maintenance scripts

*check-alfred* <br>
checks if alfred is running and restarts it if necessary, <br>
call regularly via cron (ffwp: each 5min), <br>
on gw01-03 in /usr/local/bin, <br>
file needs to have executable flag

*check-gateway*<br>
checks if vpn tunnel works (ping via tun0) and sets batman gateway flag accordingly, <br>
call regularly via cron (ffwp: each 5min), <br>
on gw01-03 in /usr/local/bin, <br>
file needs to have executable flag
