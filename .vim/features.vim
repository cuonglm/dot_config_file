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
    augroup last_edited_line
        au!
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    augroup END
endif

" Use system clipboard
set clipboard=unnamedplus

" JSON format
command! Json execute "%!python -m json.tool"

" Show help full screen
augroup full_screen
    au!
    au FileType help only
augroup END

" Open help in new tab
cabbrev help tab help
cabbrev h tab h

" Enable matchit
runtime macros/matchit.vim
