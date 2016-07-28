# WPA Supplicant Configuration Utility

This network configuration utility only requires two configuration specifications to enable a network interface to use the WPA supplicant. Specify the configuration file to use with the daemon using a `wpa-conf` stanza in the network interface file as well as a `wpa-driver` stanza:

```
auto wlan0

iface wlan0 inet dhcp
        pre-up ifconfig $IFACE up
        wpa-conf /etc/wpa_supplicant.conf
        wpa-driver nl80211
```        

## Linking `wpa_supplicant/ifupdown.sh`

This script expects to be called from the *post-up* mode of the interface bringup. This means the script should be linked from the `/etc/network/if-up.d` directory to ensure any other configuration of the interface is done before the WPA supplicant is started. Link the script (in this case it is installed into `/etc/wpa_supplicant/ifupdown.sh` using the following:

```
$ /etc/network/if-up.d
$ ln -s ../../ifupdown.sh wpa_supplicant
```
