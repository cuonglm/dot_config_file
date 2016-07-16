#!/bin/bash

vim -N -u ~/.vim/vimrc_bundle '+NeoBundleInstall!' +qall
[ $? -eq 0 ] && echo 'Update completed!'
