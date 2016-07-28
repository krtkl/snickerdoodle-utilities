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

