#!/bin/bash

# This shell script is run before Openbox launches.
# Environment variables set here are passed to the Openbox session.

# D-bus
if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
       eval `dbus-launch --sh-syntax --exit-with-session`
fi
# 新版pcmanfm D-Bus支持

# Make GTK apps look and behave how they were set up in the gnome config tools
#[ -f /usr/libexec/gnome-settings-daemon ] && eval `/usr/libexec/gnome-settings-daemon & >/dev/null 2>&1` 

# Preload stuff for KDE apps
#if which start_kdeinit >/dev/null; then
#  LD_BIND_NOW=true start_kdeinit --new-startup +kcminit_startup &
#fi

#Force OpenOffice.org to use GTK theme
export OOO_FORCE_DESKTOP=gnome

# Xmodmap
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

# Xresources
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

#apply screen and resolution parameters
#~/.screenlayout/*.sh

# Update xdg menus for openbox
openbox-menu 2>&1 >/dev/null

## Desktop environment

#suspend to ram when 3% battery capacity left; 
~/.config/scripts/autosuspend &

# 桌面特效：部分窗口半透明、窗口阴影等
killall xcompmgr >/dev/null
xcompmgr -CcFf &

WALLPAPERS="/home/arch/.config/wallpapers /usr/share/wallpapers"
#a wallpaper taken randomly in ~/.config/wallpapers, also applied to pcmanfm's desktop
# 随机使用~/.config/wallpapers目录下的桌面背景，也适用于pcmanfm的桌面
(imgfond="$(find $WALLPAPERS -type f |sort -R |tail -1)";\
feh --bg-scale $imgfond;\
sed -i "s|^wallpaper=.*$|wallpaper=$imgfond|; s|^desktop_bg|#desktop_bg|; s|^desktop_fg|#desktop_fg|;" \
	~/.config/pcmanfm/pcmanfm.conf 2>&1 >/dev/null;\
sed -i "s|^wallpaper=.*$|wallpaper=$imgfond|; s|^desktop_bg|#desktop_bg|; s|^desktop_fg|#desktop_fg|;" \
	~/.config/pcmanfm/default/pcmanfm.conf 2>&1 >/dev/null;) &

# 指定背景图片
#feh --bg-scale ~/.config/wallpapers/Tiger_Blue.jpg


# cairo-dock
killall cairo-dock >/dev/null
cairo-dock -c &

# 桌面特效 cairo-compmgr （相对比较耗资源）
#killall cairo-compmgr >/dev/null
#cairo-compmgr

PANEL="fbpanel"

killall $PANEL > /dev/null 2>&1
$PANEL & > /dev/null

# set centbar
#killall centbar > /dev/null 2>&1
#centbar & > /dev/null

# 使用pcmanfm管理桌面
killall pcmanfm >/dev/null
pcmanfm --desktop &
# 新版pcmanfm

# wbar
#killall wbar >/dev/null
#wbar &

# Conky
#killall conky > /dev/null 2>&1
#conky -c /etc/xdg/conkyrc.openbox & > /dev/null

#screen goes off after 10mn of inactivity
#xset dpms 0 0 600 &

# vattery
#killall vattery > /dev/null 2>&1
#vattery & >/dev/null

#BatterySystemTray
killall BatterySystemTray > /dev/null 2>&1
BatterySystemTray & >/dev/null

#sound volume control in the tray
volumeicon &

# Networkmanager-applet
nm-applet --sm-disable & >/dev/null 2>&1

# wicd
#killall wicd-client > /dev/null 2>&1
#wicd-client & > /dev/null 2>&1

#addons
#(while [ -z "$(pidof openbox)" ];do sleep 1;done && for addon in /addons/xsession/*;do ($addon &);done) &

#===========================================================
# 输入法 （Archlive 输入法预配置）
if [ "x${INPUT_APP}" = "x" ]; then
        export INPUT_APP=fcitx
fi
# 输入法选项 INPUT_APP 优先在 ~/.bash_profile 或者其他先启动的
# 配置文件中中作为全局变量指定
# INPUT_APP 目前可选项：
# fcitx: 小企鹅输入法
# yong: 小小输入法
# ibus: IBUS——新一代输入框架，支持拼音、五笔、二笔等等 
# scim： SCIM--传统输入法
#=======================================
case ${INPUT_APP} in
        fcitx) # 使用小企鹅输入法
                export XIM=fcitx
                export XMODIFIERS="@im=fcitx"
                export XIM_PROGRAM="/usr/bin/fcitx"
                export GTK_IM_MODULE="xim"
                export QT_IM_MODULE="xim"
                export XIM_ARGS="-d"
                [ -z "$(pidof fcitx)" ] && (fcitx &)
                ;;
        yong) # 使用小小输入法
                export XIM=yong
                export XMODIFIERS="@im=yong"
                export XIM_PROGRAM="/usr/bin/yong"
                export GTK_IM_MODULE="xim"
                export QT_IM_MODULE="xim"
                export XIM_ARGS="-d"
                [ -z "$(pidof fcitx)" ] && (yong -d &)
                ;;
        ibus) # 使用ibus输入框架
                export XMODIFIERS="@im=ibus"
                export GTK_IM_MODULE="ibus"
                export QT_IM_MODULE="ibus"
                export XIM=ibus
                export XIM_PROGRAM=/usr/bin/ibus-daemon
                export XIM_ARGS="-d -x"
                pkill -9 ibus-daemon
                ibus-daemon -d -x 
                #ibus&
                ;;
        scim) # 使用scim输入框架
                export XIM=scim
                export XMODIFIERS="@im=scim"
                export XIM_PROGRAM="/usr/bin/scim"
                export GTK_IM_MODULE="scim-bridge"
                export QT_IM_MODULE="scim-bridge"
                export XIM_ARGS="-d"
                [ -z "$(pidof scim)" ] && (scim-bridge &)
                ;;
        *) # 暂时没有该输入法的配置文件，请自行添加
                echo "暂时没有该输入法的配置文件，请自行添加"
                ;;
        esac
#===========================================================
