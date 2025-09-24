#!/bin/bash

url="https://discord.com/api/download/stable?platform=linux&format=deb" 

localversion=$(cat /usr/share/discord/resources/build_info.json | jq .version | sed 's/"//g' | tr -d '\r\n');

onlineversion=$(curl -sI "$url" | grep location | awk '{print $2}' | sed -E 's|.*discord-([0-9.]+)\.deb|\1|' | tr -d '\r\n');

if [ "$localversion" != "$onlineversion" ]; then
  curl -L --output install.deb "$url";
  sudo apt install ./install.deb -y;
  rm -f ./install.deb;
fi;

nohup discord >/dev/null 2>&1 &

