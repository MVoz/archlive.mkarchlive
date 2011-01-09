#!/bin/sh
# Released under the WTFPL

function setdefault() {
	sed -i 's/PANEL=.*/PANEL=\"tint2\"/g' ~/.config/openbox/autostart.sh 2>&1 >/dev/null
}

function nohide() {
	sed -i 's/autohide = 1/autohide = 0/' ~/.config/tint2/tint2rc 2>&1 >/dev/null
}

function hidden() {
	sed -i 's/autohide = 0/autohide = 1/' ~/.config/tint2/tint2rc 2>&1 >/dev/null
}

function refresh() {
	killall fbpanel 2>&1 >/dev/null
	killall tint2 2>&1 >/dev/null
	killall lxpanel 2>&1 >/dev/null
	tint2 &
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
