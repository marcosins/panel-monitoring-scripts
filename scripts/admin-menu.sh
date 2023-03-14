#!/usr/bin/env bash

option=$(zenity --list \
--title="With great powers..." \
--column="Option" --column="Description" \
--width="90" \
--height="230" \
1 "Terminal" \
2 "Task Manager" \
3 "Uptime" \
99 "Kill Process"
)

case $option in
    1)
        xfce4-terminal;;
    2)
        xfce4-taskmanager;;
    3)
        zenity --info --title "Uptime" --text "$(uptime -p)";;
    99)
        xkill;;
    -1)
        exit;;
esac

exit 0
