#!/bin/sh
# Released under the WTFPL

function setdefault() {
	sed -i 's/PANEL=.*/PANEL=\"lxpanel\"/g' ~/.config/openbox/autostart.sh 2>&1 >/dev/null
}

function nohide() {
#	sed -i 's/autohide=1/autohide=0/' ~/.config/lxpanel/Openbox/panels/panel 2>&1 >/dev/null
	sed -i 's/autohide=1/autohide=0/' ~/.config/lxpanel/default/panels/panel 2>&1 >/dev/null
}

function hidden() {
#	sed -i 's/autohide=0/autohide=1/' ~/.config/lxpanel/Openbox/panels/panel 2>&1 >/dev/null
	sed -i 's/autohide=0/autohide=1/' ~/.config/lxpanel/default/panels/panel 2>&1 >/dev/null
}

function refresh() {
	killall fbpanel 2>&1 >/dev/null
	killall tint2 2>&1 >/dev/null
	killall lxpanel 2>&1 >/dev/null
	lxpanel &
}

case "$1" in
	setnohide)
		setdefault
		nohide
		refresh
	;;
	sethidden)
		setdefault
		hidden
		refresh
	;;
	*)
		echo "This script accepts the following arguments : setnohide, sethidden"
esac
