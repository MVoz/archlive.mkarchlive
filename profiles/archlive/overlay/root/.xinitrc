#.xinitrc

# 字体分辨率
XRESOURCES=`mktemp /tmp/xrdb.XXXXXX`
cat >> $XRESOURCES << EOF
Xft.dpi: 96
Xft.hinting: 1
Xft.hintstyle: hintmedium
EOF


xrdb -nocpp -merge $XRESOURCES
rm -f $XRESOURCES

[ -x /usr/share/dropbox/dropbox ] && /usr/share/dropbox/dropbox &

#exec /etc/X11/xinit/xinitrc.fluxbox
exec /etc/X11/xinit/xinitrc.openbox
#exec /etc/X11/xinit/xinitrc.lxde
#exec /etc/X11/xinit/xinitrc.icewm
#exec /etc/X11/xinit/xinitrc.awesome
#exec fvwm2
