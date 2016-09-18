" Vimrc config

" Syntax highlighting
syntax on

" Set <leader> to space bar
let mapleader = " "

" Number lines visible
set number

" Highlight search
set hlsearch 
set incsearch

" Disable case-sensitive search
set ic

" Indentation
set autoindent
set smartindent

" Soft tabs are 4 spaces
set shiftwidth=4
set softtabstop=4
set tabstop=5
set expandtab

" Abbreviations / aliases
abbr pdb import pdb; pdb.set_trace()

set nocompatible              " be iMproved, required
filetype off                  " required

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/syntastic'
Plugin 'ervandew/supertab'
Plugin 'wincent/command-t'

call vundle#end()            " required
filetype plugin indent on    " required

" Command-T keybindings
let g:CommandTCancelMap='<Esc>'

" Syntastic recommended settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" pylint
set makeprg=pylint\ --reports=n\ --output-format=parseable\ %:p
set errorformat=%f:%l:\ %m

" Disable arrow keys (so I can get used to HJKL)
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
