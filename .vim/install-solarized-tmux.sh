#!/bin/bash

GIT=$(command -v git)
CAT=$(command -v cat)
REPO="https://github.com/seebi/tmux-colors-solarized.git"

base_dir=${0%/*}

if [ ! -d "${base_dir}/tmux-colors-solarized" ]; then
  "$GIT" clone "$REPO"
fi

case "$1" in
   (dark) "$CAT" "${base_dir}/tmux-colors-solarized/tmuxcolors-dark.conf" >> ~/.tmux.conf ;;
  (light) "$CAT" "${base_dir}/tmux-colors-solarized/tmuxcolors-light.conf" >> ~/.tmux.conf ;;
      (*) "$CAT" "${base_dir}/tmux-colors-solarized/tmuxcolors-256.conf" >> ~/.tmux.conf ;;
esac
