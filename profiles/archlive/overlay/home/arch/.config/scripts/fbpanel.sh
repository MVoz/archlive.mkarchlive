#!/bin/sh
# Released under the GPL

function setdefault() {
	sed -i 's/PANEL=.*/PANEL=\"fbpanel\"/g' ~/.config/openbox/autostart.sh 2>&1 >/dev/null
}

function fbnohide() {
	sed -i 's/autohide = true/autohide = false/' ~/.config/fbpanel/default 2>&1 >/dev/null
}

function fbhidden() {
	sed -i 's/autohide = false/autohide = true/' ~/.config/fbpanel/default 2>&1 >/dev/null
}

function refresh() {
	killall tint2 2>&1 >/dev/null
	killall fbpanel 2>&1 >/dev/null
	killall lxpanel 2>&1 >/dev/null
	fbpanel &
}


case "$1" in
	setnohide)
		setdefault
		fbnohide
		refresh
	;;
	sethidden)
		setdefault
		fbhidden
		refresh
	;;
	*)
		echo "This script accepts the following arguments : setnohide, sethidden"
esac
