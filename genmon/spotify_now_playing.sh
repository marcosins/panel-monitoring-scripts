#!/usr/bin/env bash
# Dependencies: bash, spotify, playerctl

# Makes the script more portable
readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Optional icon to display before the text
# Insert the absolute path of the icon
# Recommended size is 24x24 px
ICON=""
INFO=""

readonly SEPARATOR="·" #︙·
readonly ICON_MORE="…"
readonly ICON_PLAY="⯈"
readonly ICON_PAUSE="⏸"
readonly ICON_STOP="⯀"
readonly MAX_CHARS=100
readonly MESSAGE_NO_MUSIC="Click to open Spotify"
readonly PLAYER_STATUS=$(playerctl status)
readonly TIME=$(playerctl metadata --format "{{ duration(position) }} / {{ duration(mpris:length) }}")

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
  readonly TRACK=$(playerctl metadata xesam:trackNumber)
  ARTIST_TITLE="${ARTIST} ${SEPARATOR} ${TITLE}"

  # Proper length handling
  readonly STRING_LENGTH="${#ARTIST_TITLE}"
  readonly CHARS_TO_REMOVE=$(( STRING_LENGTH - MAX_CHARS ))
  [ "${#ARTIST_TITLE}" -gt "${MAX_CHARS}" ] \
    && ARTIST_TITLE="${ARTIST_TITLE:0:-CHARS_TO_REMOVE} …"

  # Panel
  INFO+="<txt>"
  INFO+="${ICON} "
  INFO+="${ARTIST_TITLE} "
  INFO+="(${TIME}) "
  INFO+="</txt>"

  INFO+="<txtclick>playerctl play-pause</txtclick>"

  # Tooltip
  TOOLTIP="<tool>"
  TOOLTIP+="🎵 <b>${TRACK} - ${TITLE}</b>\n"
  TOOLTIP+="💿 ${ALBUM}\n"
  TOOLTIP+="🎤 ${ARTIST}"
  TOOLTIP+="</tool>"
else
  INFO+="<txt>"
  INFO+="${ICON} ${MESSAGE_NO_MUSIC}"
  INFO+="</txt>"
  INFO+="<txtclick>spotify</txtclick>"

  # Tooltip
  TOOLTIP="<tool>"
  TOOLTIP+="${MESSAGE_NO_MUSIC}"
  TOOLTIP+="</tool>"
fi

# Panel Print
echo -e "${INFO}"

# Tooltip Print
echo -e "${TOOLTIP}"
