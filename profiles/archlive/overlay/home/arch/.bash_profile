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


USE_IBUS=0   #use ibus input 
USE_SCIM=0   #use scim input
USE_YONG=0
USE_FCITX=1
#=======================================
if [ ${USE_SCIM} -eq 1 ] ;then
    export XIM=scim
    export XMODIFIERS="@im=scim"
    export XIM_PROGRAM="/usr/bin/scim"
    export GTK_IM_MODULE="scim-bridge"
    export QT_IM_MODULE="scim-bridge"
    export XIM_ARGS="-d"
fi
#=======================================
if [ ${USE_IBUS} -eq 1 ] ;then
    export XMODIFIERS="@im=ibus"
    export GTK_IM_MODULE="ibus"
    export QT_IM_MODULE="ibus"
    export XIM=ibus
    export XIM_PROGRAM=/usr/bin/ibus
    #ibus-deamon&
    #ibus&
fi
#=======================================
if [ ${USE_YONG} -eq 1 ] ;then
    export XIM=yong
    export XMODIFIERS="@im=yong"
    export XIM_PROGRAM="/usr/bin/yong"
    export GTK_IM_MODULE="xim"
    export QT_IM_MODULE="xim"
    export XIM_ARGS="-d"
fi
#=======================================
if [ ${USE_FCITX} -eq 1 ] ;then
    export XIM="fcitx"
    export XMODIFIERS="@im=fcitx"
    export XIM_PROGRAM="/usr/bin/fcitx"
    export GTK_IM_MODULE="fcitx"
    export QT_IM_MODULE="fcitx"
    export XIM_ARGS="-d"
fi
#=======================================

function myntp() {
    sudo ntpdate -u clock.nc.fukuoka-u.ac.jp &>/dev/null
    #sudo ntpdate -u ntp.ubuntu.com &>/dev/null
    #sudo ntpdate -u ntp.ubuntu.com.cn &>/dev/null

    if [ "0" = $? ] ; then
        echo "ntpdate update ok"
        sudo hwclock --systohc &>/dev/null
        #sudo hwclock -w &>/dev/null
        if [ "0" = $? ] ; then
            echo "hwclock --sytohc OK"
        else
            echo "hwclock --sytohc OK"
        fi
    else
        sudo ntpdate -u ntp.ubuntu.com &>/dev/null
        if [ "0" = $? ] ; then
            sudo hwclock --systohc &>/dev/null
        else
            echo "ntpdate update error"
        fi
    fi
}

