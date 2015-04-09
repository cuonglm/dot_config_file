" Salt state files
augroup sls
    autocmd!
    " Function to setting sls file
    fun Slsconfig()
        if getline(1) =~# '\v^#!py(dsl|)$'
            set filetype=python
            call Set_tab_spaces(4)
        else
            set filetype=yaml
            call Set_tab_spaces(2)
        endif
    endfunction

    autocmd BufRead,BufNewFile *.sls call Slsconfig()
augroup END

" Python
fun Python_config()
    NeoBundleSource vim-python-pep8-indent
    let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict'
    let g:jedi#popup_on_dot = 0
endf
autocmd Filetype python :call Python_config()

" Javascript
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

" HTML
autocmd FileType html,markdown set omnifunc=htmlcomplete#CompleteTags

" PHP
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

" Haskell
autocmd FileType haskell set omnifunc=necoghc#omnifunc
let g:necoghc_enable_detailed_browse = 1

" Lua
fun Lua_config()
    let g:lua_safe_omni_modules = 0
    let g:lua_define_omnifunc = 0
    let g:lua_complete_omni = 0
    call Set_tab_spaces(2)
endf
autocmd Filetype lua :call Lua_config()

" Shell
autocmd Filetype sh,zsh,tcsh,csh :call Set_tab_spaces(2)
