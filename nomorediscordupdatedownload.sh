#!/bin/bash

url="https://discord.com/api/download/stable?platform=linux&format=deb" 

localversion=$(cat /usr/share/discord/resources/build_info.json | jq .version | sed 's/"//g');

onlineversion=$(curl -sI "$url" | grep location | awk '{print $2}' | sed -E 's|.*discord-([0-9.]+)\.deb|\1|');

if [[ "$localversion" == "$onlineversion" ]]; then
  discord;
else
  curl -L --output install.deb "$url";
  sudo apt install ./install.deb -y && nohup discord >/dev/null 2>&1 &
fi;
