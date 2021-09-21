""""""""""""""""""""""""""""""""""
" CuongLM 's vimrc file "
""""""""""""""""""""""""""""""""""

"dein Scripts-----------------------------
if &compatible
  " Set 'nocompatible' to ward off unexpected things that your distro might
  " have made, as well as sanely reset options when re-sourcing .vimrc
  set nocompatible
endif

" Required:
set runtimepath+=/Users/cuonglm/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/Users/cuonglm/.cache/dein')

" Let dein manage dein
" Required:
call dein#add('/Users/cuonglm/.cache/dein/repos/github.com/Shougo/dein.vim')

" Recommended to install
call dein#add('Shougo/vimproc.vim', {
            \ 'build' : {
            \     'windows' : 'make -f make_mingw32.mak',
            \     'cygwin' : 'make -f make_cygwin.mak',
            \     'mac' : 'make -f make_mac.mak',
            \     'unix' : 'make -f make_unix.mak',
            \     'linux' : 'make',
            \    },
            \ })

" My Bundle
call dein#add('tpope/vim-markdown')
call dein#add('Glench/Vim-Jinja2-Syntax')
call dein#add('rkulla/pydiction')
call dein#add('pangloss/vim-javascript')
call dein#add('altercation/vim-colors-solarized')
call dein#add('scrooloose/nerdtree')
call dein#add('Shougo/neocomplcache')
call dein#add('fatih/vim-go')
call dein#add('vim-scripts/awk-support.vim')
call dein#add('sjl/gundo.vim')
call dein#add('fs111/pydoc.vim')
call dein#add('ervandew/supertab')
call dein#add('mileszs/ack.vim')
call dein#add('eagletmt/ghcmod-vim')
call dein#add('eagletmt/neco-ghc')
call dein#add('davidhalter/jedi-vim')
call dein#add('vim-ruby/vim-ruby')
call dein#add('tpope/vim-rails')
call dein#add('tpope/vim-fugitive')
call dein#add('xolox/vim-misc')
call dein#add('xolox/vim-lua-ftplugin')
call dein#add('scrooloose/syntastic')
call dein#add('honza/dockerfile.vim')
call dein#add('chase/vim-ansible-yaml')
call dein#add('stephpy/vim-yaml')
call dein#add('bling/vim-airline')
call dein#add('tomasr/molokai')
call dein#add('elixir-lang/vim-elixir')
call dein#add('tpope/vim-surround')
call dein#add('xolox/vim-session')
call dein#add('chriskempson/vim-tomorrow-theme')
call dein#add('nickhutchinson/vim-systemtap')
call dein#add('justmao945/vim-clang')
call dein#add('scrooloose/nerdcommenter')
call dein#add('majutsushi/tagbar')
call dein#add('rust-lang/rust.vim')
call dein#add('chrisbra/unicode.vim')

" neovim
if has('nvim')
    call dein#add('brettanomyces/nvim-terminus')
end

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
" if dein#check_install()
"   call dein#install()
" endif

"End dein Scripts-------------------------

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
