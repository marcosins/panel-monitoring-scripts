#!/usr/bin/env bash

# configuration
readonly UA="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:111.0) Gecko/20100101 Firefox/111.0"
readonly CLICK="xdg-open http://192.168.0.1" # your router address
readonly HOST="github.com" # be careful with how many request you send
readonly TIMEOUT=8

# code
readonly HTTP_RESPONSE=($(curl -s -L -I -X GET -A $UA --connect-timeout $TIMEOUT $HOST | grep HTTP | tail -n 1 | cut -f2 -d " "))

STATUS=$([[ $HTTP_RESPONSE != "200" ]] && \
  echo -e "<tool>No HTTP response from ${HOST^^}</tool>" || \
  echo -e "<tool>HTTP response from ${HOST^^} is $HTTP_RESPONSE</tool>")

ICON=$([[ $HTTP_RESPONSE != "200" ]] && \
  echo -e "<icon>network-error</icon>" || \
  echo -e "<icon>network-connect</icon>")

NOTIFICATION=$([[ $HTTP_RESPONSE != "200" ]] && \
  notify-send -u normal -i network-error -c network.error "Internet error" "No HTTP response from ${HOST^^}")

# genmon
echo -e "$ICON"
echo -e "$STATUS"
echo -e "<iconclick>$CLICK</iconclick>"

exit
