#!/usr/bin/env bash

# configuration
UA="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:111.0) Gecko/20100101 Firefox/111.0"
CLICK="xdg-open http://192.168.0.1" # your router address
HOST="github.com" # be careful with how many request you send

# code
HTTP_RESPONSE=($(curl -s -L -I -X GET -A $UA --connect-timeout 4 $HOST | grep HTTP | tail -n 1 | cut -f2 -d " "))

STATUS=$([[ $HTTP_RESPONSE == "200" ]] && \
  echo -e "<tool>HTTP response from ${HOST^^} is $HTTP_RESPONSE</tool>" || \
  echo -e "<tool>No HTTP response from ${HOST^^}</tool>")

ICON=$([[ $HTTP_RESPONSE == "200" ]] && \
  echo -e "<icon>network-connect</icon>" || \
  echo -e "<icon>network-error</icon>")

NOTIFICATION=$([[ $HTTP_RESPONSE != "200" ]] && \
  notify-send -u normal -i network-error -c network.error "Internet error" "HTTP response from ${HOST^^} was not successful")

# genmon
echo -e "$ICON"
echo -e "$STATUS"
echo -e "<iconclick>$CLICK</iconclick>"

exit
