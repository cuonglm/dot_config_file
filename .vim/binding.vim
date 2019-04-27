"""""""""""""
" bind keys "
"""""""""""""

" Counting number of occurences
map \c :%s///gn<CR>

" Quick write
nnoremap \s :up!<CR>

" jk as Escape
inoremap jk <Esc>

" Space to turn off highlight search
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Toggle highlight column and row
nnoremap <silent> <F3> :set cuc! cul!<CR>

" Toggle line number
nnoremap <silent> <F4> :set nu!<CR>

" F2 to toggle paste mode
set pastetoggle=<F2>

" remap keys to move around the windows
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" long lines as break lines
map j gj
map k gk

" save file with sudo
cmap w!! w !sudo tee > /dev/null %

" toggle Gundo window
map \g :GundoToggle<CR>

" pep8_map
let g:pep8_map='\c8'

" Do not use arrow keys
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" Ack
nmap \a <Esc>:Ack!

" OSX need "*y for yanking
if has('mac')
    vnoremap y "*y
endif

" Personal quick typing
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {;<CR>  {<CR>};<Esc>O
inoremap {{     {
inoremap {}     {}

inoremap [      []<Left>
inoremap [<CR>  [<CR>]<Esc>O
inoremap [[     [
inoremap []     []

inoremap (      ()<Left>
inoremap (<CR>  (<CR>)<Esc>O
inoremap (;<CR>  (<CR>);<Esc>O
inoremap ((     (
inoremap ()     ()

" vim-go
nnoremap <silent> gs :GoSameIdsToggle<CR>
nnoremap <silent> gr :GoReferrers<CR>
