#!/bin/bash

# Create dummy .vimrc file
[ -f ~/.vimrc ] && mv ~/.vimrc{,_bak}
cp ~/.vim/vimrc ~/.vimrc

# Create backup dir
mkdir ~/.vim/backup 2>/dev/null

# Install NeoBundle
[ -d ~/.vim/bundle/neobundle.vim ] || git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
vim -N -u ~/.vim/vimrc_bundle +NeoBundleInstall +qall
