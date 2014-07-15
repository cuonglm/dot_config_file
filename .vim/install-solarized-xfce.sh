#!/bin/bash

GIT=$(command -v git)
CP=$(command -v cp)

# Config xfce terminal with solarized-theme
has_xfce=

case $DESKTOP_SESSION in
    (*xfce*) has_xfce=yes ;;
         (*) has_xfce= ;;
esac

if [ -n "$has_xfce" ] && [ ! -d xfce4-terminal-colors-solarized ]
then
    $GIT clone https://github.com/sgerrand/xfce4-terminal-colors-solarized.git
fi

case "$1" in
    (dark) $CP xfce4-terminal-colors-solarized/dark/terminalrc ~/.config/Terminal/ ;;
   (light) $CP xfce4-terminal-colors-solarized/light/terminalrc ~/.config/Terminal/ ;;
       (*) echo "Usage: $0 light|dark"
esac
