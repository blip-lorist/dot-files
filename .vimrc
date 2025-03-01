" Vimrc config

" Syntax highlighting
syntax on

" Origami config
" https://unix.stackexchange.com/questions/141097/how-to-enable-and-use-code-folding-in-vim
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" Magic vim-instant-markdown plugin
filetype plugin on

" Remove trailing whitespace. Thanks @thenashfactor!
let trim_filetype_banlist = ['markdown']
autocmd BufWritePre * if index(trim_filetype_banlist, &ft) < 0 | :%s/\s\+$//e

" Whitespace for languages
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Set <leader> to space bar
let mapleader = " "

" Backspacing like I shouldn't
set backspace=2

" Number lines visible
set number

" Highlight search
set hlsearch
set incsearch
hi Search cterm=NONE ctermfg=grey ctermbg=blue
hi ALEWarning ctermfg=grey ctermbg=DarkMagenta
hi Visual ctermfg=black ctermbg=grey


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

" Abbreviations / aliases
abbr pdb import pdb; pdb.set_trace()
abbr pry require 'pry'; binding.pry

call plug#begin('~/.vim/plugged')
" Install with :PlugInstall

Plug 'w0rp/ale'
Plug 'scrooloose/nerdtree'
Plug 'ajh17/VimCompletesMe'
Plug 'tpope/vim-surround'
Plug 'elzr/vim-json'
Plug 'tpope/vim-abolish'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'shime/vim-livedown'

" Ctags for gems
Plug 'tpope/vim-rbenv'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-fugitive'

call plug#end()

" Ctag path
set tags=./.git/tags

" Lightline recommended setting
set laststatus=2

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

" Magical :FormatJSON
com! FormatJSON %!python -m json.tool

" Update javac class path to use Princeton Algorithms course path
let g:ale_java_javac_classpath = "/usr/local/algs4/algs4.jar:/home/loraine/algorithms-course/*"

" OMG you can get vim to recognize your dotfiles
" This may have issues on Ubuntu
" set shellcmdflag=-ic
