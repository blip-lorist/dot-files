" Vimrc config

" Syntax highlighting
syntax on

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

" Pathogen install
execute pathogen#infect()

" Syntastic recommended settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
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
