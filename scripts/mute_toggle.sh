#!/usr/bin/env bash

microphone-sensitivity-muted

amixer -D pulse set Capture toggle

STATE=($(amixer -D pulse cget numid=2 | grep " values=" | cut -f2 -d "=")) # get the id from `pacmd list-sources`

ICON=$([[ ${STATE} == "on" ]] && \
  echo -e "audio-input-microphone" || \
  echo -e "microphone-sensitivity-muted")

notify-send "Microhpone" -i $ICON "Mic is $STATE" -u normal
exit
