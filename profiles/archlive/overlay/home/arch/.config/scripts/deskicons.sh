#!/bin/sh
# Released under the WTFPL

case "$1" in
        seticons)
                [ -z "$(grep -Eo "^pcmanfm --desktop" ~/.config/openbox/autostart.sh)" ] &&
                (sed -i 's/#pcmanfm --desktop/pcmanfm --desktop/' ~/.config/openbox/autostart.sh;\
                pcmanfm --desktop &)
        ;;
        setnoicons)
                [ -n "$(grep -Eo "^pcmanfm --desktop" ~/.config/openbox/autostart.sh)" ] &&
                (sed -i 's/^pcmanfm --desktop/#pcmanfm --desktop/g' ~/.config/openbox/autostart.sh;\
                pcmanfm --desktop-off &)
        ;;
        *)
                echo "This script accepts the following arguments : seticons, setnoicons"
esac

