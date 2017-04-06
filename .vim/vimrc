""""""""""""""""""""""""""""""""""
" CuongLM aka Gnouc's vimrc file "
""""""""""""""""""""""""""""""""""

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

source $HOME/.vim/vimrc_bundle
source $HOME/.vim/helper.vim
source $HOME/.vim/theme.vim
source $HOME/.vim/features.vim
source $HOME/.vim/plugins.vim
source $HOME/.vim/custom_functions.vim
source $HOME/.vim/custom_filetype.vim
source $HOME/.vim/binding.vim
source $HOME/.vim/nvim.vim

augroup vimrc_reload
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc,*.vim so $MYVIMRC |
                \ if has('gui_running') | so $MYGVIMRC | endif
augroup END
