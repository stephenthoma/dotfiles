" Use Vim settings rather than Vi
set nocompatible

" Pathogen
call pathogen#infect()
call pathogen#helptags()

" Do syntax highlighting
syntax on
filetype plugin indent on

set background=dark
colorscheme solarized

" Always display status line
set laststatus=2

" Switch off wrapping
set nowrap
set tabstop=2
set shiftwidth=2
set expandtab
" Backspace over anything
set backspace=2

" jj to leave Insert mode
imap jj <Esc>

" Always show cursor position
set ruler

" No more help
nmap <F1> <Esc>

" Scroll Vim with mouse
set mouse=a

" Only do if compiled with support for autocommands.
if has("autocmd")
	" Enable file type detection and language-dependent indentation.
	filetype plugin indent on

	" Automagically load .vimrc source when saved
	autocmd BufWritePost .vimrc source $MYVIMRC

	" Jump to last known cursor position
	autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
        \ 	exe "normal g'\"" |
        \ endif

else
	set autoindent
endif




" Use powerline
"python from powerline.vim import setup as powerline_setup
"python powerline_setup()
"python del powerline_setup

" Hide default mode text (ie. -- INSERT -- )
"set noshowmode
