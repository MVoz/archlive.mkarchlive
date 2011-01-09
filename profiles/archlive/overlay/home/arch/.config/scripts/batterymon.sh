#!/bin/sh
# Released under the WTFPL

case "$1" in
	set)
		sed -i 's/#BatterySystemTray/BatterySystemTray/' ~/.config/openbox/autostart.sh
		[ -z "$(pidof BatterySystemTray)" ] && BatterySystemTray &
	;;
	unset)
		sed -i 's/^BatterySystemTray/#BatterySystemTray/g' ~/.config/openbox/autostart.sh
		killall BatterySystemTray
	;;
	*)
		echo "This script accepts the following arguments : set, unset"
esac
