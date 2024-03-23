# Source of inspiration from https://weworkweplay.com/play/rebooting-the-raspberry-pi-when-it-loses-wireless-connection-wifi/
# Function to check network connectivity
# Change the ip address to match your local router's ip address or some other ip address you know should be reachable
ip_address="192.168.1.1"

check_network() {
    ping -c4 "$ip_address" > /dev/null
    return $?
}

# Initial network check
check_network

if [ $? != 0 ]; then
    echo "No network connection, restarting wlan0"
    /sbin/ifdown 'wlan0'
    sleep 10
    /sbin/ifup --force 'wlan0'

    # Wait for network to come up after reset
    sleep 20

    # Check network connectivity after resetting
    check_network

    if [ $? != 0 ]; then
        echo "Network still unreachable after reset, rebooting..."
        sudo reboot
    fi
fi
