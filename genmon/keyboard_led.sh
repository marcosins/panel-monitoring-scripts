#!/usr/bin/env bash

# configuration
ON_COLOR_CAPS="#C1FFD7"
ON_COLOR_NUM="#94B3FD"
ON_COLOR_SCROLL="#FFF89A"
CLICK="xfce4-keyboard-settings"

# code
STATE=($(xset q | grep Caps\ Lock | awk '{print $4" "$8" "$12}'))

CAPS=$([[ ${STATE[0]} == "on" ]] && \
  echo -e "<span foreground='black' background='$ON_COLOR_CAPS'> 🄰 </span>" || \
  echo -e " 🄰 ")

NUM=$([[ ${STATE[1]} == "on" ]] && \
  echo -e "<span foreground='black' background='$ON_COLOR_NUM'> 🄽 </span>" || \
  echo -e " 🄽 ")

SCROLL=$([[ ${STATE[2]} == "on" ]] && \
  echo -e "<span foreground='black' background='$ON_COLOR_SCROLL'> 🅂 </span>" || \
  echo " 🅂 ")

# genmon
echo -e "<txt>$CAPS$NUM$SCROLL</txt>"
echo -e "<tool><b>Keyboard indicators:</b>
 🄰 CAPS
 🄽 NUM
 🅂 SCROLL</tool>"
echo -e "<txtclick>$CLICK</txtclick>"

exit 0
