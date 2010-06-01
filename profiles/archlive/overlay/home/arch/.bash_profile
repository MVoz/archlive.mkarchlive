
export XAUTHORITY="/tmp/${USER}.Xauthority"
export RXVT_SOCKET="/tmp/.rxvtc-unicode-`uname -n`"
export GTK2_RC_FILES=$HOME/.gtkrc-2.0
#export TZ='Asia/Shanghai'

function cv () {
    cdargs "$1" && cd "`cat "$HOME/.cdargsresult"`" && pwd;
}

#Or you can remove the file in which cdargs reports it's result:

function cvr () {
    cdargs "$1" && cd "`cat "$HOME/.cdargsresult"`" && rm -f "$HOME/.cdargsresult";
}

pathmunge () {
    if ! echo $PATH | /bin/egrep -q "(^|:)$1($|:)" ; then
        if [ "$2" = "after" ] ; then
            PATH=$PATH:$1
        else
            PATH=$1:$PATH
        fi
    fi
}

#===========================================================
# 输入法 （Archlive 输入法预配置）
export INPUT_APP=fcitx
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
		#[ -z "$(pidof fcitx)" ] && (fcitx &)
		;;
	yong) # 使用小小输入法
		export XIM=yong
		export XMODIFIERS="@im=yong"
		export XIM_PROGRAM="/usr/bin/yong"
		export GTK_IM_MODULE="xim"
		export QT_IM_MODULE="xim"
		export XIM_ARGS="-d"
		#[ -z "$(pidof fcitx)" ] && (yong -d &)
		;;
	ibus) # 使用ibus输入框架
		export XMODIFIERS="@im=ibus"
		export GTK_IM_MODULE="ibus"
		export QT_IM_MODULE="ibus"
		export XIM=ibus
		export XIM_PROGRAM=/usr/bin/ibus-daemon
		export XIM_ARGS="-d -x"
		#pkill -9 ibus-daemon
		#ibus-daemon -d -x 
		#ibus&
		;;
	scim) # 使用scim输入框架
		export XIM=scim
		export XMODIFIERS="@im=scim"
		export XIM_PROGRAM="/usr/bin/scim"
		export GTK_IM_MODULE="scim-bridge"
		export QT_IM_MODULE="scim-bridge"
		export XIM_ARGS="-d"
		#[ -z "$(pidof scim)" ] && (scim-bridge &)
		;;
	*) # 暂时没有该输入法的配置文件，请自行添加
		echo "暂时没有该输入法的配置文件，请自行添加"
		;;
	esac
#===========================================================