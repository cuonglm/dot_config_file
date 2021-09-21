#!/bin/bash

# Create dummy .vimrc file
[ -f ~/.vimrc ] && mv ~/.vimrc{,_bak}
cp ~/.vim/init.vim ~/.vimrc

# Create backup dir
mkdir -p ~/.cache/dein/backup 2>/dev/null

# Install Dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein
