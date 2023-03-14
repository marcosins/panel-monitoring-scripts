#!/usr/bin/env bash
# Dependencies: bash, amixer, cut, grep

# configuration
CLICK="mute_toggle.sh"

# code
STATE=($(amixer -D pulse cget numid=2 | grep " values=" | cut -f2 -d "=")) # get the id from `pacmd list-sources`

MIC=$([[ ${STATE^^} == "ON" ]] && \
  echo -e "<icon>audio-input-microphone</icon>" || \
  echo -e "<icon>microphone-sensitivity-muted</icon>")

# genmon
echo -e "$MIC"
echo -e "<tool>Microphone is ${STATE^^}</tool>"
echo -e "<iconclick>$CLICK</iconclick>"

exit 0
