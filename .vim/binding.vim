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
nnoremap <silent> <F5> :Texplore<CR>
set pastetoggle=<F2>

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

nnoremap \s :up!<CR>

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
let g:pep8_map='\8'

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
