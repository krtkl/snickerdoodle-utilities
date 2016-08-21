# HOSTAPD Configuration Utility

This network configuration utility only requires a single specification to enable a network interface to be configured for access point mode (AP) using `hostapd`. Specify the configuration file to use with the server using a `hostapd-conf` stanza in the network interface file:

```
auto wlan1

iface wlan1 inet static
        address 10.0.110.2
        gateway 255.255.255.0
        hostapd-conf /etc/hostapd.conf
```        

## Linking `hostapd/ifupdown.sh`

This script expects to be called from the *pre-up*, *post-up* and *post-down* modes of the interface bringup/down. This means the script should be linked from the `/etc/network/if-pre-up.d`, `/etc/network/if-up.d` and `/etc/network/if-post-down.d` directories to ensure any other configuration of the interface is done before the access point is started and after the access point is stopped. Link the script (in this case it is installed into `/etc/hostapd/ifupdown.sh` using the following:

```
$ cd /etc/network/if-pre-up.d
$ ln -s ../../ifupdown.sh hostapd
$ cd /etc/network/if-up.d
$ ln -s ../../ifupdown.sh hostapd
$ cd /etc/network/if-post-down.d
$ ln -s ../../ifupdown.sh hostapd
```

The resulting structure of the `/etc/network` directory should look something like the following:

```
$ tree /etc/network
/etc/network
├── if-down.d
│   ├── resolvconf
│   └── upstart
├── if-post-down.d
│   └── hostapd -> ../../hostapd/ifupdown.sh
├── if-pre-up.d
│   └── hostapd -> ../../hostapd/ifupdown.sh
├── if-up.d
│   ├── 000resolvconf
│   ├── dhcpd -> ../../dhcpd/ifupdown.sh
│   ├── hostapd -> ../../hostapd/ifupdown.sh
│   ├── ntpdate
│   ├── openssh-server
│   ├── upstart
│   └── wpa_supplicant -> ../../wpa_supplicant/ifupdown.sh
├── interfaces
├── interfaces.d
│   ├── wlan0
│   └── wlan1
└── run -> /run/network
```
