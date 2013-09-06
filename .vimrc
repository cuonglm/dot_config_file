""""""""""""""""""""""""""""""""""
" CuongLM aka Gnouc's vimrc file "
""""""""""""""""""""""""""""""""""

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Set dark background
set background=dark

" Syntax highlighting
syntax enable

" Set colorscheme
"colorscheme desert
"colorscheme pyte
"colorscheme grb256 
colorscheme vividchalk 
"colorscheme distinguished 
"colorscheme developer 
"colorscheme tidy 

" Enable file type detection
if has("autocmd")
  filetype plugin indent on
endif

" Do smart autoindenting when starting a new line 
set smartindent

" Show matched pattern when search
set incsearch

" Highlight mathed pattern
set hlsearch

" Ignore case of normal letter
set ignorecase

" Override the 'ignorecase' option if 
" the search pattern contains upper case characters
set smartcase

" Smart with tab
set smarttab

" Show line and column of cursor position
set ruler

" Show command
set showcmd

" Complete longest common string, then each full match
set wildmode=longest:full
set wildmenu

" Adding character form pairs
set matchpairs+=<:>

" Number of space that <Tab> count
set tabstop=4

" In Insert mode: Use the appropriate number of spaces to insert a <Tab>
set expandtab

" Number of spaces to use for each step of (auto)indent)
set shiftwidth=4

" Round indent to multiple of 'shiftwidth'
set shiftround

" Don't wrap long line
set nowrap

" Allow backspace over anything
set backspace=indent,eol,start

" Set backup
if has("vms")
    set nobackup
else
    set backup
endif

set backupdir=~/.vim/backup/
set dir=~/.vim/backup/

" Back to last edited line
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Turn off highlight search in insert mode
augroup hlsearch
    autocmd!
    autocmd InsertEnter * :setlocal nohlsearch
    autocmd InsertLeave * :setlocal hlsearch
augroup END

" Show help full screen
autocmd FileType help only

" Don't add comment automatically
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Use system clipboard
set clipboard=unnamedplus

"""""""""""""
" bind keys "
"""""""""""""

map \c i{<Esc>ea}<Esc>
map \p i(<Esc>ea)<Esc>
map \q i'<Esc>ea'<Esc>
map \dq i"<Esc>ea"<Esc>
map \C :%s///gn<CR>

inoremap jk <Esc>
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
nnoremap <silent> <F3> :set cuc! cul!<CR>
nnoremap <silent> <F4> :set nu!<CR>
set pastetoggle=<F2>

inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

inoremap [      []<Left>
inoremap [<CR>  [<CR>]<Esc>O
inoremap [[     [
inoremap []     [] 

inoremap (      ()<Left>
inoremap (<CR>  (<CR>)<Esc>O
inoremap ((     (
inoremap ()     ()

nnoremap <leader>s :w!<CR>

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
