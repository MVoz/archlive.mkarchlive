#.xinitrc

. $HOME/.xprofile

# 字体分辨率
XRESOURCES=`mktemp /tmp/xrdb.XXXXXX`
cat >> $XRESOURCES << EOF
Xft.dpi: 96
Xft.hinting: 1
Xft.hintstyle: hintmedium
EOF

# 开启 Ctrl + Alt + Backspace 无敌三键
setxkbmap -option terminate:ctrl_alt_bksp

# 加载农历支持
if [ -f liblunar-gtk-preload.so ]; then
	export LD_PRELOAD="/usr/lib/liblunar-gtk-preload.so"
fi

xrdb -nocpp -merge $XRESOURCES
rm -f $XRESOURCES

[ -x /usr/share/dropbox/dropbox ] && /usr/share/dropbox/dropbox &

#exec /etc/X11/xinit/xinitrc.fluxbox
#exec /etc/X11/xinit/xinitrc.openbox
exec startlxde
#exec /etc/X11/xinit/xinitrc.icewm
#exec /etc/X11/xinit/xinitrc.awesome
#exec fvwm2
