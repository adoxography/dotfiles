set nocompatible

call plug#begin('~/.vim/plugged')

    " Visuals -------------------------------------------------------------- {{{
    " Colour schemes
    Plug 'arcticicestudio/nord-vim'
    Plug 'bluz71/vim-nightfly-guicolors'
    " Display hex codes as the colour they represent
    Plug 'chrisbra/Colorizer'
    " }}}

    " Navigation ----------------------------------------------------------- {{{
    " Birds-eye view of the file system
    Plug 'scrooloose/nerdtree'
    " Like CtrlP, but faster
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    " Find and replace
    Plug 'skwp/greplace.vim'
    " Git interaction from within vim
    Plug 'tpope/vim-fugitive'
    " Automatically manage ctags
    Plug 'ludovicchabant/vim-gutentags'
    " }}}

    " Editor enhancements -------------------------------------------------- {{{
    " Easy comment toggling
    Plug 'tpope/vim-commentary'
    " Surrounding commands
    Plug 'tpope/vim-surround'
    " Enable repeated plugin commands
    Plug 'tpope/vim-repeat'
    " Shell commands from vim
    Plug 'tpope/vim-eunuch'
    " Testing from within vim
    Plug 'janko-m/vim-test'
    " Intellisense
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Pairs
    Plug 'rstacruz/vim-closer'
    Plug 'tpope/vim-endwise'
    " Snippets
    Plug 'SirVer/ultisnips'
    Plug 'mattn/emmet-vim'
    " Search enhancement
    Plug 'markonm/traces.vim'
    Plug 'airblade/vim-gitgutter'
    " }}}

    " Language enhancements ------------------------------------------------ {{{
    " Many
    Plug 'sheerun/vim-polyglot'
    " C#
    Plug 'OmniSharp/omnisharp-vim'
    " }}}

call plug#end()
