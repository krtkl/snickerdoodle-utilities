# HOSTAP Server Configuration Utility

This network configuration utility only requires a single specification to enable a network interface to be configured for access point mode (AP) using `hostapd`. Specify the configuration file to use with the server using a `hostapd-conf` stanza in the network interface file:

```
auto wlan1

iface wlan1 inet static
        address 10.0.110.2
        gateway 255.255.255.0
        hostapd-conf /etc/hostapd.conf
```        

## Linking `hostapd/ifupdown.sh`

This script expects to be called from the *post-up* mode of the interface bringup. This means the script should be linked from the `/etc/network/if-up.d` directory to ensure any other configuration of the interface is done before the access point is started. Link the script (in this case it is installed into `/etc/hostapd/ifupdown.sh` using the following:

```
$ /etc/network/if-up.d
$ ln -s ../../ifupdown.sh hostapd
```
