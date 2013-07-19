""""""""""""""""""""""""""""""""""
" CuongLM aka Gnouc's vimrc file "
""""""""""""""""""""""""""""""""""

set nocompatible

set background=dark

syntax enable

"colorscheme desert
"colorscheme pyte
"colorscheme grb256 
colorscheme vividchalk 
"colorscheme distinguished 
"colorscheme developer 
"colorscheme tidy 

"if has("autocmd")
"  filetype plugin indent on
"endif

set smartindent

set incsearch

set hlsearch

set ignorecase

set smartcase

set smarttab

set ruler

set showcmd

set wildmode=longest:full
set wildmenu

set matchpairs+=<:>

set tabstop=4

set sw=4

set expandtab

set shiftwidth=4

set shiftround

set nowrap

set backspace=indent,eol,start

if has("vms")
    set nobackup
else
    set backup
endif

set backupdir=~/.vim/backup/
set dir=~/.vim/backup/

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

augroup hlsearch
    autocmd!
    autocmd InsertEnter * :setlocal nohlsearch
    autocmd InsertLeave * :setlocal hlsearch
augroup END

"""""""""""""
" bind keys "
"""""""""""""

:map \c i{<Esc>ea}<Esc>
:map \p i(<Esc>ea)<Esc>
:map \q i'<Esc>ea'<Esc>
:map \dq i"<Esc>ea"<Esc>

"inoremap ( ()<Esc>i
"inoremap { {}<Esc>i
"inoremap [ []<Esc>i
inoremap jk <Esc>
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

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
