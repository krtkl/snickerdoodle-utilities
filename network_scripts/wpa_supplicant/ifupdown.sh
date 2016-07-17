#!/bin/sh

# Copyright (c) 2016 krtkl inc.
# Russell Bush <bush@krtkl.com>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#


NAME="wpa_supplicant"
DESC="IEEE 802.1X/WPA authenticator"
WPA_BIN="/usr/local/sbin/wpa_supplicant"

. /lib/lsb/init-functions

# quit if we're called for lo
if [ "$IFACE" = lo ]; then
        exit 0
fi

if [ ! -x "$WPA_BIN" ]; then
        exit 0
fi


echo "Configuring wpa_supplicant for $IFACE"
# The configuration file and driver are required hooks
if [ -n "$IF_WPA_CONF" ] && [ -n "$IF_WPA_DRIVER" ]; then
        WPA_CONF="$IF_WPA_CONF"
        WPA_DRIVER="$IF_WPA_DRIVER"

        WPA_OPTS="-D$WPA_DRIVER -c$WPA_CONF -i$IFACE"
else
        echo "wpa_supplicant hooks not specified for $IFACE"
        exit 0
fi


init_wpa_supplicant() {
        [ -n "$IF_WPA_OPTIONS" ] && WPA_OPTS="$IF_WPA_OPTIONS $WPA_OPTS"

        log_daemon_msg "Starting $DESC" "$NAME"
        start-stop-daemon --start --oknodo --quiet --exec "$WPA_BIN" \
                -- $WPA_OPTS >/dev/null
#       /usr/local/sbin/wpa_supplicant $WPA_OPTS
        log_end_msg "$?"

        if [ "$?" -ne 0 ]; then
                return "$?"
        fi

        return 0
}

kill_wpa_supplicant() {
        echo "Stopping wpa_supplicant"
        return 0
}

case "$MODE" in
        start)
                case "$PHASE" in
                        post-up)
                                init_wpa_supplicant || exit 1
                                ;;
                        *)
                                exit 1
                                ;;
                esac
                ;;
        stop)
                case "$PHASE" in
                        post-down)
                                kill_wpa_supplicant
                                ;;
                        *)
                                exit 1
                                ;;
                esac
                ;;
        *)
                exit 1
                ;;
esac

exit 0
