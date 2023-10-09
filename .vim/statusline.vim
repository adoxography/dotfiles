let s:modified_status = "%{&modified?'\ \ +':''}"
let s:readonly_status = "%{&readonly?'\ \ ':''}"
let s:coc_status = "%{coc#status()}%{get(b:,'coc_current_function','')}"
let s:file_type_status = "\ %{''!=#&filetype?&filetype:'none'}"
let s:file_format_status = "%(\ %{(&bomb\|\|'^%\|utf-8'!~#&fileencoding?'\ '.&fileencoding.(&bomb?'-bom':''):'').('unix'!=#&fileformat?'\ '.&fileformat:'')}%)"
let s:tab_status = "%(\ \ %{&modifiable?(&expandtab?'et\ ':'noet\ ').&shiftwidth:''}%)"

function! ActiveStatus()
    let statusline=""
    let statusline.="%1*"
    let statusline.="%(%{'help'!=&filetype?'\ \ '.bufnr('%'):''}\ %)"
    let statusline.="%2*"
    let statusline.=""
    let statusline.="%{FugitiveHead()!=''?'\ \ '.FugitiveHead().'\ ':''}"
    let statusline.="%3*"
    let statusline.=""
    let statusline.="%4*"
    let statusline.="\ %<"
    let statusline.="%f"
    let statusline.=s:modified_status
    let statusline.=s:readonly_status
    let statusline.="%="
    let statusline.=s:coc_status
    let statusline.=s:file_type_status
    let statusline.=s:file_format_status
    let statusline.=s:tab_status
    let statusline.="%3*"
    let statusline.="\ "
    let statusline.="%2*"
    let statusline.=""
    let statusline.="%1*"
    let statusline.="\ %l:%2c"
    let statusline.="\ %3p%%\ "
    return statusline
endfunction

function! InactiveStatus()
    let statusline=""
    let statusline.="%(%{'help'!=&filetype?'\ \ '.bufnr('%').'\ \ ':'\ '}%)"
    let statusline.="%{FugitiveHead()!=''?'\ \ '.FugitiveHead().'\ ':'\ '}"
    let statusline.="\ %<"
    let statusline.="%f"
    let statusline.=s:modified_status
    let statusline.=s:readonly_status
    let statusline.="%="
    let statusline.=s:file_type_status
    let statusline.=s:file_format_status
    let statusline.=s:tab_status
    let statusline.="\ "
    let statusline.="\ %l:%2c"
    let statusline.="\ %3p%%"
    return statusline
endfunction

" Always show the status
set laststatus=2
set statusline=%!ActiveStatus()

hi User1 guibg=#88c0d0 guifg=#2e3440 ctermfg=black ctermbg=darkcyan
hi User2 guibg=#3b4252 guifg=#88c0d0 ctermfg=darkcyan ctermbg=black
hi User3 guifg=#3b4252 ctermfg=black
hi User4 guifg=#e5e9f0

augroup status
    autocmd!
    autocmd WinEnter * setlocal statusline=%!ActiveStatus()
    autocmd WinLeave * setlocal statusline=%!InactiveStatus()
augroup END
