""""""""""""""""""""""""""""""""""
" CuongLM aka Gnouc's vimrc file "
""""""""""""""""""""""""""""""""""
set textwidth=78

set nocompatible

set number

syntax on

"colorscheme desert
colorscheme pyte
"colorscheme elflord
"colorscheme default

"filetype indent plugin on

set smartindent

set incsearch

set hlsearch

set ignorecase

set smartcase

set ruler

set showcmd

set wildmode=longest:full
set wildmenu

"""""""""""""
" bind keys "
"""""""""""""

:map \c i{<Esc>ea}<Esc>
:map \p i(<Esc>ea)<Esc>
:map \q i'<Esc>ea'<Esc>
:map \dq i"<Esc>ea"<Esc>

""""""""""""""""""""""""""""""""
"Tab Completion in Insert Mode "
""""""""""""""""""""""""""""""""

function! Tab_Or_Complete()
  if col('.') > 1 && strpart( getline('.'), col('.') - 2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
