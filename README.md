# checkwifi
 This is a simple script that pings your local network router. If the ping fails, the script will attempt to reset wifi networking. It will then attempt another ping. If that ping also fails, the script will reboot the device.

 Initial source of inspiration came from https://weworkweplay.com/play/rebooting-the-raspberry-pi-when-it-loses-wireless-connection-wifi/.

##checkwifi.sh
Store this script in /usr/local/bin/checkwifi.sh

Change the IP on the first line to the IP of your router, or some other device on your network that you can assume will be always online.

Make sure the script has the correct permissions to run:
```
sudo chmod 775 /usr/local/bin/checkwifi.sh
```

##crontab
SSH into your device and open up the crontab editor by typing `crontab -e`.

Add the following line:
```
*/5 * * * * /usr/bin/sudo -H /usr/local/bin/checkwifi.sh >> /dev/null 2>&1
```
This runs the script every 5 minutes as sudo (so you have permission to do the shutdown command), writing its output to /dev/null so it won't clog your syslog.
