#!/usr/bin/env bash

# configuration
readonly ON_COLOR_CAPS="#C1FFD7"
readonly ON_COLOR_NUM="#94B3FD"
readonly ON_COLOR_SCROLL="#FFF89A"
readonly SYMBOL_CAPS="CAPS" # 🄰
readonly SYMBOL_NUM="NUMS" # 🄽
readonly SYMBOL_SCROLL="SCRL" # 🅂
readonly CLICK="xfce4-keyboard-settings"

# code
STATE=($(xset q | grep Caps\ Lock | awk '{print $4" "$8" "$12}'))

CAPS=$([[ ${STATE[0]^^} == "ON" ]] && \
  echo -e "<span foreground='black' background='$ON_COLOR_CAPS'> <b>$SYMBOL_CAPS</b> </span>" || \
  echo -e " $SYMBOL_CAPS ")

NUM=$([[ ${STATE[1]^^} == "ON" ]] && \
  echo -e "<span foreground='black' background='$ON_COLOR_NUM'> <b>$SYMBOL_NUM</b> </span>" || \
  echo -e " $SYMBOL_NUM ")

SCROLL=$([[ ${STATE[2]^^} == "ON" ]] && \
  echo -e "<span foreground='black' background='$ON_COLOR_SCROLL'> <b>$SYMBOL_SCROLL</b> </span>" || \
  echo " $SYMBOL_SCROLL ")

# genmon
echo -e "<txt>$CAPS$NUM$SCROLL</txt>"
echo -e "<tool><big><b>Keyboard indicators</b></big>
 $SYMBOL_CAPS is ${STATE[0]^^}
 $SYMBOL_NUM is ${STATE[1]^^}
 $SYMBOL_SCROLL is ${STATE[2]^^}</tool>"
echo -e "<txtclick>$CLICK</txtclick>"

exit 0
