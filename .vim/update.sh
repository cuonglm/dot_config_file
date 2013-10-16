#!/bin/bash

vim -N -u ~/.vim/vimrc_bundle '+NeoBundleInstall!' '+NeoBundleClean!' +qall
[ $? -eq 0 ] && echo 'Update completed!'
