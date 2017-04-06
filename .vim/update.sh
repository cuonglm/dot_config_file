#!/bin/bash

vim=
case $1 in
  (nvim) vim=nvim ;;
     (*) vim=vim  ;;
esac

"$vim" -N -u ~/.vim/vimrc_bundle '+NeoBundleInstall!' '+call neobundle#commands#clean(1)' +qall
[ $? -eq 0 ] && echo 'Update completed!'
