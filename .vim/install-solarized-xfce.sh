#!/bin/bash

GIT=$(command -v git)
CP=$(command -v cp)
REPO="https://github.com/sgerrand/xfce4-terminal-colors-solarized.git"

# Config xfce terminal with solarized-theme
has_xfce=
base_dir=${0%/*}

case $DESKTOP_SESSION in
  (*xfce*) has_xfce=yes ;;
       (*) has_xfce= ;;
esac

if [ -n "$has_xfce" ] && [ ! -d "${base_dir}/xfce4-terminal-colors-solarized" ]
then
  "$GIT" clone "$REPO"
fi

case $1 in
   (dark) "$CP" "${base_dir}/xfce4-terminal-colors-solarized/dark/terminalrc" ~/.config/Terminal/ ;;
  (light) "$CP" "${base_dir}/xfce4-terminal-colors-solarized/light/terminalrc" ~/.config/Terminal/ ;;
      (*) printf "Usage: %s light|dark\n" "$0"
esac
