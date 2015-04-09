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

" Use system clipboard
set clipboard=unnamedplus

" JSON format
command Json execute "%!python -m json.tool"

" Show help full screen
autocmd FileType help only

" Open help in new tab
cabbrev help tab help
cabbrev h tab h
