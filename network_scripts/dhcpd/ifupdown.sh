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


NAME="dhcpd"
DESC="Internet systems consortium DHCP server"
DHCPD_BIN="/usr/sbin/dhcpd"

. /lib/lsb/init-functions


# quit if we're called for lo
if [ "$IFACE" = lo ]; then
        exit 0
fi

if [ ! -x "$DHCPD_BIN" ]; then
        exit 0
fi


# The configuration file is the daemon hook
if [ -n "$IF_DHCPD_CONF" ]; then
        DHCPD_CONF="$IF_DHCPD_CONF"
else
        exit 0
fi


init_dhcpd() {
        DHCPD_OPTS="-cf $DHCPD_CONF $IFACE"

        log_daemon_msg "Starting $DESC" "$NAME"
        start-stop-daemon --start --oknodo --quiet --exec "$DHCPD_BIN" \
                -- $DHCPD_OPTS >/dev/null
        log_end_msg "$?"

        if [ "$?" -ne 0 ]; then
                return "$?"
        fi

        return 0
}

kill_dhcpd() {
        echo "Stopping dhcpd"
        return 0
}

case "$MODE" in
        start)
                case "$PHASE" in
                        post-up)
                                init_dhcpd || exit 1
                                ;;
                        *)
                                exit 1
                                ;;
                esac
                ;;
        stop)
                case "$PHASE" in
                        post-down)
                                kill_dhcpd
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
