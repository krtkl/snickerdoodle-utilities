# Network Configuration Scripts

The network configuration scripts consist of a hook script for each utility (hostapd, wpa_supplicant, etc.) which is intended to be linked within the network ifupdown directories.

## Script Installation

To install the scripts, copy utility folders into `/etc` and create symbolic links within the ifupdown folder corresponding with the stage (MODE) of network bringup that should be used to configure the interface. 

### Create `ifupdown` Links

Each network utility script is named `ifupdown.sh` within the utility directory as convention. For readability, when creating links to `ifupdown` directory, the link should be named something more descriptive or renamed after the utility (e.g. `hostapd`) that it is responsible for configuring. To create such a link, use `ln -s` from the terminal:


```
$ cd /etc/network/if-up.d
$ ln -s ../../hostapd/ifupdown.sh hostapd
```
