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

" WP to switch to word processing environment
func! WordProcessorMode()
    setlocal formatoptions=t1
    setlocal textwidth=80
    map j gj
    map k gk
    setlocal smartindent
    setlocal spell spelllang=en_us
    setlocal noexpandtab
endfu
com! WP call WordProcessorMode()

" Toggle auto-indent for pasting
nnoremap <F3> :set invpaste paste?<CR>
set pastetoggle=<F3>
set showmode

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

nmap <silent> <special> <F2> :NERDTreeToggle<RETURN>

" Use powerline
"python from powerline.vim import setup as powerline_setup
"python powerline_setup()
"python del powerline_setup

" Hide default mode text (ie. -- INSERT -- )
"set noshowmode
