" Use Vim settings rather than Vi
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'

Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'ntpeters/vim-better-whitespace'

Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'

Plugin 'Lokaltog/vim-easymotion'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ervandew/supertab'
Plugin 'tmhedberg/matchit'

Plugin 'pangloss/vim-javascript'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'digitaltoad/vim-pug'
Plugin 'groenewege/vim-less'
Plugin 'w0rp/ale'
call vundle#end()

" Ale linter settings
let g:ale_linters = {'javascript': ['eslint']}
let g:ale_fixers = {'javascript': ['eslint']}
let g:ale_lint_on_text_changed = 'never'
map <F1> :ALEFix<CR>

" Change some colors
highlight SignColumn ctermbg=237
highlight Folded ctermbg=237
highlight ALEErrorSign guifg=Red guibg=NONE ctermbg=237 ctermfg=203
highlight ALEError guifg=255 guibg=203 ctermbg=203 ctermfg=255

" Use ag with CtrlP plugin
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Do syntax highlighting
syntax on

" Always display status line
set laststatus=2

" Switch off wrapping
set nowrap
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Code folding
set foldmethod=syntax
set foldnestmax=3
set nofoldenable
set foldlevel=2
" js folding
syntax region foldBraces start=/{/ end=/}/ transparent fold keepend extend

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

" w!! to force write file
cmap w!! w !sudo tee % >/dev/null

" Toggle auto-indent for pasting
nnoremap <F3> :set invpaste paste?<CR>
set pastetoggle=<F3>
set showmode
set incsearch

" Backspace over anything
set backspace=2

" jj to leave Insert mode
imap jj <Esc>

" Always show cursor position
set ruler

" Scroll Vim with mouse
set mouse=a

set clipboard=unnamed
" Only do if compiled with support for autocommands.
if has("autocmd")
	" Enable file type detection and language-dependent indentation.
	filetype plugin indent on

	" Automagically load .vimrc source when saved
	"autocmd BufWritePost .vimrc source $MYVIMRC

	" Jump to last known cursor position
	autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
        \ 	exe "normal g'\"" |
        \ endif

else
	set autoindent
endif

nmap <silent> <special> <F2> :NERDTreeToggle<RETURN>

" Navigate windows without C-w prefix
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Hide default mode text (ie. -- INSERT -- )
"set noshowmode
