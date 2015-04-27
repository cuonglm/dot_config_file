""""""""""""""""""
" Custom tabline "
""""""""""""""""""
set tabline=%!MyTabLine()
fun! MyTabLine()
    let s = '' " complete tabline goes here
    " loop through each tab page
    for t in range(tabpagenr('$'))
        " set highlight
        if t + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif
        " set the tab page number (for mouse clicks)
        let s .= '%' . (t + 1) . 'T'
        let s .= ' '
        " set page number string
        let s .= t + 1 . ' '
        " get buffer names and statuses
        let n = ''      "temp string for buffer names while we loop and check buftype
        let m = 0       " &modified counter
        let bc = len(tabpagebuflist(t + 1))     "counter to avoid last ' '
        " loop through each buffer in a tab
        for b in tabpagebuflist(t + 1)
            " buffer types: quickfix gets a [Q], help gets [H]{base fname}
            " others get 1dir/2dir/3dir/fname shortened to 1/2/3/fname
            if getbufvar( b, "&buftype" ) == 'help'
                 let n .= '[H]' . fnamemodify( bufname(b), ':t:s/.txt$//' )
            elseif getbufvar( b, "&buftype" ) == 'quickfix'
                 let n .= '[Q]'
            else
                 let n .= pathshorten(bufname(b))
            endif
            " check and ++ tab's &modified count
            if getbufvar( b, "&modified" )
                 let m += 1
            endif
            " no final ' ' added...formatting looks better done later
            if bc > 1
                 let n .= ' '
            endif
            let bc -= 1
        endfor
        " add modified label [n+] where n pages in tab are modified
        if m > 0
             let s .= '[' . m . '+]'
        endif
        " select the highlighting for the buffer names
        " my default highlighting only underlines the active tab
        " buffer names.
        if t + 1 == tabpagenr()
             let s .= '%#TabLineSel#'
        else
             let s .= '%#TabLine#'
        endif
        " add buffer names
        if n == ''
             let s.= '[New]'
        else
             let s .= n
        endif
        " switch to no underlining and add final space to buffer list
        let s .= ' '
    endfor
    " after the last tab fill with TabLineFill and reset tab page nr
    let s .= '%#TabLineFill#%T'
    " right-align the label to close the current tab page
    if tabpagenr('$') > 1
         let s .= '%=%#TabLineFill#%999Xclose'
    endif
    return s
endfunction

""""""""""""""""""""""""""""""""
"Tab Completion in Insert Mode "
""""""""""""""""""""""""""""""""

fun! Tab_Or_Complete()
  if col('.') > 1 && strpart( getline('.'), col('.') - 2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

"""""""""""""""""""""""""""
"Auto highlight variables "
"""""""""""""""""""""""""""

" Vawa Plugin for VIM > 7.3 version 1.00
" Maintainer: Sandeep.c.r<sandeepcr2@gmail.com>
" Hacked for Perl by Curtis "Ovid" Poe <ovid@allaroundtheworld.fr>

function! s:vawa()
    call clearmatches()
    let s:temp          = getpos('.')
    let s:current_col   = s:temp[2]
    let s:current_line  = s:temp[1]
    let s:temp          = searchpos('[>$@%*&]','bcn')
    let s:sigil_line    = s:temp[0]
    let s:sigil_col     = s:temp[1]
    if(s:sigil_line != s:current_line)
        return
    endif
    let s:temp = getbufline(bufnr('%'),line('.'))
    let s:varend = match(s:temp[0], '[^a-zA-Z0-9_\x7f-\xff]\|\n', s:sigil_col)+1
    let s:space_col = s:varend
    if((s:space_col > s:sigil_col) && ( s:space_col< s:current_col))
        return
    endif
    if(s:varend == 0)
        let s:varend = strlen(s:temp[0])+1
    endif
    let s:current_char = s:temp[0][s:current_col-1]
    if(s:current_char == '>' || s:current_char == '-')
        return
    endif
    if(exists("g:vawahl"))
        exe "highlight VarHl  " . g:vawahl
    else
        highlight VarHl  ctermbg=black ctermfg=red guifg=#ff0000 guibg=#000000 ctermfg=LightRed gui=bold
    endif
    let s:str = strpart(s:temp[0], s:sigil_col-1,(s:varend - s:sigil_col))
    let s:prefix = ''
    if(exists("g:vawanohlcurrent") && (g:vawanohlcurrent == 1))
        let s:lineab = s:current_line - 1
        let s:linebe = s:current_line + 1
        let s:colbf  = s:sigil_col + 1
        let s:prefix = '\(\%>'.s:lineab.'l.\%<'.s:linebe.'l.\%>'.s:colbf.'c\)\@!'
    endif
    if(s:str == '$')
        return
    endif
    if(strpart(s:str,0,1) == '>')
        let s:str = strpart(s:str ,1)
        call matchadd('VarHl', s:prefix.'>\@<='. s:str.'\n\{-\}\(\([^a-zA-Z0-9_\x7f-\xff]\)\|$\)\@=')
    else
        call matchadd('VarHl', s:prefix.s:str.'\n\{-\}\(\([^a-zA-Z0-9_\x7f-\xff]\)\|$\)\@=')
    endif
endfunction
if(!exists("g:vawanoauto") || (g:vawanoauto == 1))
    augroup HighlightVar
            autocmd!
            au CursorMoved  *.pl call <sid>vawa()
            au CursorMovedi *.pl call <sid>vawa()
            au CursorMoved  *.pm call <sid>vawa()
            au CursorMovedi *.pm call <sid>vawa()
            au CursorMoved  *.t  call <sid>vawa()
            au CursorMovedi *.t  call <sid>vawa()
    augroup END
endif

command! Vawa :call <sid>vawa()
