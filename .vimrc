" Vimrc config

" Syntax highlighting
syntax on

" Syntastic - Use latest Ruby version
let g:syntastic_ruby_mri_exec = '~/.rbenv/shims/ruby'


" Set <leader> to space bar
let mapleader = " "

" Backspacing like I shouldn't
set backspace=2

" Number lines visible
set number

" Highlight search
set hlsearch 
set incsearch

" Disable case-sensitive search
set ic

" Indentation and tab-space replacements
set expandtab " Use spaces, not tabs, for autoindent/tab key."
set autoindent " always set autoindenting on"
set smartindent " use smart indent if there is no indent file"
set tabstop=2 " <tab> inserts 4 spaces"
set softtabstop=2 " <BS> over an autoindent deletes 4 spaces."
set smarttab " Handle tabs more intelligently"
set shiftwidth=2 " an indent level is 4 spaces wide."
set shiftround " rounds indent to a multiple of shiftwidth"

" Abbreviations / aliases
abbr pdb import pdb; pdb.set_trace()
abbr pry require 'pry'; binding.pry

set nocompatible              " be iMproved, required
filetype off                  " required

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'ervandew/supertab'
Plugin 'tpope/vim-surround'
Plugin 'elzr/vim-json'
Plugin 'tpope/vim-abolish'

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

" Don't write backup if editing cron
if $VIM_CRONTAB == "true"
  set nobackup
  set nowritebackup
endif

" NerdTREE shortcut
map <C-n> :NERDTreeToggle<CR>
