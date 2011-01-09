#!/bin/sh
# Released under the GPL v3

#if lsmod | grep "alsa" 2>&1 >/dev/null; then
#	APP="volumeicon-alsa"
#else
#	APP="volumeicon-oss"
#fi
# 让volumeicon自行判断是alsa或者oss

# 切换主题
if [ "x$(ps -A | grep fbpanel)" = "x" ]; then
	sed -i "s|theme=.*|theme=Black\ Gnome|" ~/.config/volumeicon/volumeicon
else
	sed -i "s|theme=.*|theme=White\ Gnome|" ~/.config/volumeicon/volumeicon
fi

APP="volumeicon"
case "$1" in
	set)
		echo "APP=$APP"
		sed -i 's/#${APP//-*}*/$APP/' ~/.config/openbox/autostart.sh 2>&1 >/dev/null
		[ -z "$(pidof $APP)" ] && $APP &
	;;
	unset)
		sed -i 's/#${APP//-*}*/$APP/' ~/.config/openbox/autostart.sh 2>&1 >/dev/null
		killall $APP-oss 2>&1 >/dev/null
		killall $APP-alsa 2>&1 >/dev/null
	;;
	*)
		echo "This script accepts the following arguments : set, unset"
esac
