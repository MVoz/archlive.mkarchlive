#!/bin/bash

DATE=`date '+%Y%m%d%H%M%S'`
FNAME=fvwm${DATE}.png
USERNAME="user"
PASS="password"
SERVER="name server"
DELAY="3"
QUALITY="75"

cd /home/arch/Desktop\ and\ photos/Screenshots/
scrot -d ${DELAY} -q ${QUALITY} ${FNAME}

#scrot -b -d 3 -s '/home/arch/Desktop/%Y%m%d_%H%M%S_$wx$h.png' -e 'gpicview $f'
