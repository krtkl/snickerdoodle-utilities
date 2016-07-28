# DHCP Server Configuration Utility

This network configuration utility only requires a single specification to enable a network interface to use the DHCP service. Specify the configuration file to use with the server using a `dhcpd-conf` stanza in the network interface file:

```
auto wlan1

iface wlan1 inet static
        address 10.0.110.2
        gateway 255.255.255.0
        dhcpd-conf /etc/dhcpd.conf
```        

## Linking `dhcpd/ifupdown.sh`

This script expects to be called from the *post-up* mode of the interface bringup. This means the script should be linked from the `/etc/network/if-up.d` directory to ensure any other configuration of the interface is done before the DHCP service is started. Link the script (in this case it is installed into `/etc/dhcpd/ifupdown.sh` using the following:

```
$ /etc/network/if-up.d
$ ln -s ../../ifupdown.sh dhcpd
```
