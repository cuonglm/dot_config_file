#!/bin/bash

vim=
case $1 in
  (nvim) vim=nvim ;;
     (*) vim=vim  ;;
esac

"$vim" -N -u NONE '+call dein#update()' +qall
[ $? -eq 0 ] && echo 'Update completed!'
