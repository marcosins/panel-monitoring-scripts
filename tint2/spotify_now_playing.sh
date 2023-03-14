#!/usr/bin/env bash

INFO=""
ICON=""

readonly MAX_CHARS=60
readonly SEPARATOR="·"
readonly ICON_MORE="…"
readonly ICON_PLAY="⯈"
readonly ICON_PAUSE="⏸" #▌▌ o ▐ ▌
readonly ICON_STOP="⯀"
readonly MESSAGE_NO_MUSIC="Open Spotify"
readonly PLAYER_STATUS=$(playerctl status)

case $PLAYER_STATUS in
  "Playing") ICON=${ICON_PLAY};;
  "Paused") ICON=${ICON_PAUSE};;
  *) ICON=${ICON_STOP};;
esac

if pidof spotify &> /dev/null; then
  # Spotify song's info
  readonly ARTIST=$(playerctl metadata xesam:artist)
  readonly ALBUM=$(playerctl metadata xesam:album)
  readonly TITLE=$(playerctl metadata xesam:title)

  INFO="${ARTIST} ${SEPARATOR} ${TITLE}"

  # Proper length handling
  readonly STRING_LENGTH="${#ARTIST}"
  readonly CHARS_TO_REMOVE=$(( STRING_LENGTH - MAX_CHARS ))
  if [ "${#INFO}" -gt "${MAX_CHARS}" ]; then
    INFO="${INFO:0:-CHARS_TO_REMOVE}${ICON_MORE}"
  else
    INFO="${ARTIST} ${SEPARATOR} ${TITLE}"
  fi
else
    INFO+=$MESSAGE_NO_MUSIC
fi

# Panel Print
echo -e "${ICON} ${INFO}"

exit 0
