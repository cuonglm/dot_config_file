#!/bin/bash

GIT=$(command -v git)
CAT=$(command -v cat)

if [ ! -d "tmux-colors-solarized" ]
then
    $GIT clone https://github.com/seebi/tmux-colors-solarized.git
fi

case "$1" in
    (dark) $CAT tmux-colors-solarized/tmuxcolors-dark.conf >> ~/.tmux.conf ;;
   (light) $CAT tmux-colors-solarized/tmuxcolors-light.conf >> ~/.tmux.conf ;;
       (*) $CAT tmux-colors-solarized/tmuxcolors-256.conf >> ~/.tmux.conf ;;
esac
