#!/bin/bash

# This shell script is run before Openbox launches.
# Environment variables set here are passed to the Openbox session.

# D-bus
#if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
#       eval `dbus-launch --sh-syntax --exit-with-session`
#fi
# 新版pcmanfm 需要注释掉(枪花提供)

# Make GTK apps look and behave how they were set up in the gnome config tools
[ -f /usr/libexec/gnome-settings-daemon ] && eval `/usr/libexec/gnome-settings-daemon & >/dev/null 2>&1` 

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

# 使用pcmanfm管理桌面
killall pcmanfm >/dev/null
#pcmanfm -d &
pcmanfm --desktop &
# 新版pcmanfm

# 背景图片
#feh --bg-scale ~/.config/wallpapers/Tiger_Blue.jpg

# 桌面特效：部分窗口半透明、窗口阴影等
#killall xcompmgr >/dev/null
#xcompmgr -Ss -n -Cc -fF -I-10 -O-10 -D1 -t-3 -l-4 -r4 &

# set panel
#killall tint2 > /dev/null 2>&1
#tint2 & > /dev/null

# set lxpanel
killall lxpanel > /dev/null 2>&1
lxpanel & > /dev/null

# wbar
#killall wbar >/dev/null
#wbar &

# Conky
#killall conky > /dev/null 2>&1
#conky -c /etc/xdg/conkyrc.openbox & > /dev/null

# vattery
#killall vattery > /dev/null 2>&1
#vattery & >/dev/null

# Networkmanager-applet
nm-applet --sm-disable & >/dev/null 2>&1

# wicd
#killall wicd-client > /dev/null 2>&1
#wicd-client & > /dev/null 2>&1

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
