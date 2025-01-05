set signcolumn=yes
let g:myultisnips_jump = 1

" Utility functions -------------------------------------------------------- {{{
    " SourceIfExists function ---------------------------------------------- {{{
    function! SourceIfExists(file)
        if filereadable(expand(a:file))
            exe 'source' a:file
        endif
    endfunction
    " }}}
" }}}

" Plugin loading ----------------------------------------------------------- {{{
" Make sure to use vim, not vi - required for some plugins
set nocompatible
" coc.vim wants these guys
set nobackup
set nowritebackup
" Load in plugins with Vundle
call SourceIfExists("~/.vim/plugins.vim")
" Load custom functions
call SourceIfExists("~/.vim/functions.vim")
" }}}

" Visuals ------------------------------------------------------------------ {{{
set termguicolors

if $SESSION_THEME == "nightfly"
    silent! colorscheme nightfly
elseif $SESSION_THEME == "moss"
    let g:moss_italic = 1
    let g:moss_underline = 1
    let g:moss_italic_comments = 1
    call SourceIfExists("~/.vim/moss.vim")
    silent! colorscheme moss
else
    let g:nord_italic = 1
    let g:nord_underline = 1
    let g:nord_italic_comments = 1
    silent! colorscheme nord
endif
" Show relative line numbers
set relativenumber
" Make the line column blend in with the background
highlight LineNr ctermbg=NONE guibg=NONE
" Same for the vertical split column
highlight vertsplit ctermbg=NONE guibg=NONE
" Use transparent background
highlight Normal ctermbg=NONE guibg=NONE

highlight AleErrorSign ctermbg=NONE guibg=NONE
highlight AleWarningSign ctermbg=NONE guibg=NONE
highlight clear SignColumn

if has('macunix') || system('uname -o') =~? 'darwin'
    set t_ZH=[3m t_ZR=[23m  " Set the italics code
endif

" Custom status bar
call SourceIfExists("~/.vim/statusline.vim")
" }}}

" Mappings ----------------------------------------------------------------- {{{
" , is a better leader than \
let mapleader=','
" Hop out of insert mode without having to sprain your wrist
inoremap jk <Esc>
inoremap kj <Esc>
" Add a blank line below with enter
nmap <cr> o<Esc>
noremap <S-h> ^
noremap <S-l> $
" Get to .vimrc quickly
nnoremap <leader>ev :tabedit $MYVIMRC<cr>
" Get to plugins.vim quickly
nnoremap <leader>ep :tabedit ~/.vim/plugins.vim<cr>
" Quit quickly
nnoremap <leader>q :q<cr>
" Save quickly
nnoremap <leader>ww :w<cr>
" Save and quit quickly
nnoremap <leader>wq :wq<cr>
" Turn string into a header
nnoremap <leader>h :call Header()<cr>
" Add a fold mark
vnoremap <leader>m :<c-u>MarkFold 
" Quickly run macro
nnoremap <Space> @q

" Use J and K to navigate up and down by visual lines
nnoremap <s-j> gj
nnoremap <s-k> gk

command! MakeTags !ctags .
" }}}

" Modern keyboard settings ------------------------------------------------- {{{
" Fix the stupid backspace settings
set backspace=indent,eol,start
" Magic that makes tabs work like you expect them to
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
" Make tab work normally in normal and visual modes
nnoremap <Tab> >>
vnoremap <Tab> >
" Make shift-tab work normally everywhere
nnoremap <S-Tab> <<
vnoremap <S-Tab> <
inoremap <S-Tab> <C-d>

if system('uname -s') == "Darwin\n"
    set clipboard=unnamed  " OSX
else
    set clipboard=unnamedplus  " Linux
endif
" }}}

" Split settings ----------------------------------------------------------- {{{
" Open new horizontal split below the current buffer
set splitbelow
" Open new vertical splits to the right of the current buffer
set splitright
" Use ,+- to open a horizontal split
nnoremap <leader>- :sp<cr>
" Use ,+| to open a vertical split
nnoremap <leader>\| :vsp<cr>
" Navigate between splits with Ctrl+dir in normal mode
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
" }}}

" Search settings ---------------------------------------------------------- {{{
" Turn on search highlighting
set hlsearch
" Highlight as you type
set incsearch
" Clear the highlight with ,+space
nmap <leader><space> :nohlsearch<cr>
" }}}

" Miscellaneous settings --------------------------------------------------- {{{
" Use %% as an alias for the current directory
cabbr <expr> %% expand('%:p:h')
" Toggle paste mode with F3 so that pasted code doesn't look bizarre
set pastetoggle=<F3>
" Don't wait for a half a century for vim to figure out you're done typing
set updatetime=150
" Key mappings should be typed pretty quickly, so wait for less time
set timeoutlen=600
" See options for command line completion
set wildmenu

let $ZSH_ENV="~/.aliases"

" Cursor shapes
if &term =~ '^xterm\\|rxvt'
    let &t_SI .= "\<Esc>[5 q"  " Blinking bar in insert mode
    let &t_SR .= "\<Esc>[4 q"  " Solid underscore in replace mode
    let &t_EI .= "\<Esc>[2 q"  " Solid block everywhere else (i.e. command mode)
endif
" }}}

" Autocommands ------------------------------------------------------------- {{{
if has ("autocmd")
    " Automatically source .vimrc on save ---------------------------------- {{{
    augroup autosourcing
        autocmd!
        " Source .vimrc after it's saved
        autocmd BufWritePost .vimrc nested source %
        " Source .vimrc after plugins.vim is saved
        autocmd BufWritePost plugins.vim nested source ~/.vimrc
        " Source .vimrc after functions.vim is saved
        autocmd BufWritePost functions.vim nested source ~/.vimrc
        autocmd BufWritePost statusline.vim nested source ~/.vimrc
        autocmd BufWritePost moss.vim nested source ~/.vimrc
    augroup END
    " }}}

    " Custom caret --------------------------------------------------------- {{{
    if $EMULATOR == 'gnome-terminal' || $EMULATOR == 'qterminal'
        " gnome-terminal --------------------------------------------------- {{{
         augroup gnome_terminal_caret
             autocmd!
             autocmd VimEnter,InsertLeave *
                 \ silent execute '!echo -ne "\e[1 q"' | redraw!
             autocmd InsertEnter,InsertChange *
                 \ if v:insertmode == 'i' |
                 \   silent execute '!echo -ne "\e[5 q"' | redraw! |
                 \ elseif v:insertmode == 'r' |
                 \   silent execute '!echo -ne "\e[3 q"' | redraw! |
                 \ endif
             autocmd VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
         augroup END
         " }}}
    elseif $EMULATOR == 'iterm2'
         " iterm2 ---------------------------------------------------------- {{{
         let &t_SI = "\<Esc>]50;CursorShape=1\x7"  " Vertical bar in insert mode
         let &t_EI = "\<Esc>]50;CursorShape=0\x7"  " Block in normal mode
         " }}}
    endif
    " }}}

    " Filetype settings ---------------------------------------------------- {{{
    augroup filetype_blade
        autocmd!
        autocmd BufNewFile,BufRead *.blade.php setlocal filetype=blade syntax=blade
    augroup END

    augroup filetype_tsv
        autocmd!
        autocmd BufNewFile,BufRead *.tsv inoremap <Tab> <Tab>
    augroup END
    " }}}

    " File resumption ------------------------------------------------------ {{{
    augroup resume
        autocmd!
        " Resume where you left off in a file
        autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \ exe "normal! g'\"" |
            \ endif
    augroup END
    " }}}

    " Resync vue files for accurate syntax highlighting ------------------- {{{
    augroup vue_comment
        autocmd!
        autocmd FileType vue syntax sync fromstart
    augroup END
    " }}}
endif
" }}}

" Plugin settings ---------------------------------------------------------- {{{

" coc-vim settings --------------------------------------------------------- {{{
" Cycle forward in options
let g:coc_global_extensions = [
            \ 'coc-css',
            \ 'coc-emmet',
            \ 'coc-eslint',
            \ 'coc-html',
            \ 'coc-json',
            \ 'coc-pyright',
            \ 'coc-rust-analyzer',
            \ 'coc-sh',
            \ 'coc-solargraph',
            \ 'coc-stylelintplus',
            \ 'coc-tsserver'
\ ]
inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#pum#next(1) :
            \ CheckBackspace() ? "\<TAB>" :
            \ coc#refresh()
" Cycle backward in options
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" Accept selection
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostics-prev)
nmap <silent> ]g <Plug>(coc-diagnostics-next)
" GoTo Code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Show documentation
nnoremap <silent> <leader>d :call ShowDocumentation()<CR>
" Symbol renaming
nmap <F2> <Plug>(coc-rename)
" Format selected code
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)
" Map function and class text objects
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" :Format formats current buffer
command! -nargs=0 Format :call CocActionAsync('format')
" :Fold folds current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)
" :OR organizes imports
command! -nargs=0 OR :call CocActionAsync('runCommand', 'editor.action.organizeImport')

if has ("autocmd")
    augroup cocgroup
        autocmd!
        " Highlight symbol and references
        autocmd CursorHold * silent call CocActionAsync('highlight')
        " Setup formatexpr for specified filetypes. TODO: can this be done in
        " filetype config?
        autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
        " Update signature to help on jump placeholder
        autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        " Automatically redraw status
        autocmd User CocStatusChange redrawstatus
    augroup END
endif

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction
" }}}

" Vim-LaTeX settings ------------------------------------------------------- {{{
" Load vim-latex in empty .tex files
let g:tex_flavor='latex'
" Compile to PDF, not DVI
let g:Tex_DefaultTargetFormat='pdf'
" Mark PDF as a format that will need multiple compile steps so that BibTeX
" gets processed
let g:Tex_MultipleCompileFormats='dvi,pdf'
" vim-latex's macros are really irritating. Turn them off.
let g:Imap_FreezeImap = 1
" Fix stupid vim-latex binding
imap <C-g> <Plug>IMAP_JumpForward
nmap <C-g> <Plug>IMAP_JumpForward
" }}}

" NERDTree settings -------------------------------------------------------- {{{
" Make NERDTree easier to toggle
nmap <c-b> :NERDTreeToggle<cr>
" Make NERDTree look nicer
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
" }}}

" FZF settings ------------------------------------------------------------- {{{
" Access the fuzzy finder with Ctrl + P
nnoremap <C-p> :Files<cr>
" Access the tag finder
nnoremap <leader>t :Tags<cr>
" }}}

" GReplace settings -------------------------------------------------------- {{{
" Use Ag to search
set grepprg=ag
" }}}

" Commentary settings --------------------------------------------------- {{{
" Add Ctrl+/ mapping for NERDCommenter
map <C-/> :call ToggleComment()<cr>

let g:multi_syntaxes = ['vue', 'html']

function! ToggleComment()
    let old_ft = &ft
    let should_toggle = index(g:multi_syntaxes, &ft) >= 0

    if should_toggle
        let stack = synstack(line('.'), col('.'))
        if !empty(stack)
            let syn = synIDattr((stack)[0], 'name')
            if !empty(syn)
                exe 'setf '. substitute(tolower(syn), '^vue_', '', '')
            endif
        endif
    endif

    normal gcc

    if should_toggle
        exe 'setf '. old_ft
    endif
endfunction

" }}}

let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let g:javascript_plugin_jsdoc = 1

" ALE settings ------------------------------------------------------------- {{{
let g:ale_lint_on_text_changed = 'command'
command! Lint :ALEToggle

let g:ale_linters = {
            \ 'php': ['php', 'langserver', 'phpcs', 'phan'],
            \ 'c': ['gcc'],
            \ 'cs': ['OmniSharp']
            \ }

let g:python_highlight_indent_errors = 0
let g:python_highlight_space_errors = 0
let g:python_highlight_all = 1

let g:ale_php_langserver_executable = expand('~/.composer/vendor/bin/php-language-server.php')
let g:ale_php_phpcs_executable = expand('~/.composer/vendor/bin/phpcs')
let g:ale_php_phpcs_standard = 'PSR12'
let g:ale_php_phan_executable = expand('~/bin/phan_client_auto')
let g:ale_php_phan_use_client = 1

let g:ale_c_parse_makefile = 1
let g:ale_c_parse_compile_commands = 1

let g:ale_java_javac_classpath = '/Users/grahamstill/Downloads/stanford-corenlp-full-2018-10-05/stanford-corenlp-3.9.2.jar'
" }}}

" vim-vue settings --------------------------------------------------------- {{{
" Stop vim-vue from checking every preprocessor's syntax
let g:vue_disable_pre_processors=1
" }}}

" vim-blade settings ------------------------------------------------------- {{{
let g:blade_custom_directives_pairs = {
    \   'role': 'endrole',
    \   'hasrole': 'endhasrole',
    \   'hasanyrole': 'endhasanyrole',
    \   'hasallroles': 'endhasallroles',
    \   'unlessrole': 'endunlessrole'
    \ }
" }}}

" vim-test settings -------------------------------------------------------- {{{
" let test#python#runner = 'nose'
nmap <silent> <leader>tn :TestNearest<cr>
nmap <silent> <leader>tf :TestFile<cr>
nmap <silent> <leader>ts :TestSuite<cr>
nmap <silent> t<c-g> :TestVisit<cr>
nmap <silent> <leader>tl :TestLast<cr>
" }}}

" UltiSnips settings ------------------------------------------------------- {{{
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger='<C-j>'
let g:UltiSnipsJumpBackwardTrigger='<C-k>'
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
" }}}

" Emmet -------------------------------------------------------------------- {{{
imap <expr> <c-e> emmet#expandAbbrIntelligent("\<tab>")
" }}}
