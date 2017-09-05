" Use Vim settings rather than Vi
set nocompatible
filetype off

"set packpath^=~/.vim
packadd minpac
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})

call minpac#add('altercation/vim-colors-solarized')

call minpac#add('vim-airline/vim-airline') " statusline widgets
call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('ctrlpvim/ctrlp.vim') " C-p fuzzy search
call minpac#add('jeetsukumaran/vim-buffergator') " \b to view open buffers
call minpac#add('justinmk/vim-dirvish') " path navigator
call minpac#add('ntpeters/vim-better-whitespace') " makes trailing whitespace red

call minpac#add('tpope/vim-fugitive') " git commands within vim
call minpac#add('tpope/vim-git') " syntax files for git

call minpac#add('Lokaltog/vim-easymotion') " file navigation \\w \\b
call minpac#add('christoomey/vim-tmux-navigator') " move between vim and tmux seamlessly
call minpac#add('tpope/vim-surround') " surround a word with something ysiw
call minpac#add('scrooloose/nerdcommenter') " easy commenting
call minpac#add('ervandew/supertab') " tab completion

call minpac#add('pangloss/vim-javascript') " javascript highlighting
call minpac#add('digitaltoad/vim-pug') " syntax highlighting for pug templates

call minpac#add('w0rp/ale') " syntax checking

packloadall

" minpac commands
command! PluginInstall call minpac#update()
command! PluginClean call minpac#clean()

" Ale linter settings
let g:ale_linters = {'javascript': ['eslint']}
let g:ale_fixers = {'javascript': ['eslint']}
let g:ale_lint_on_text_changed = 'never'
map <F1> :ALEFix<CR>

" Make it possible to close netrw buffers
autocmd FileType netrw setl bufhidden=wipe

" Change some colors
highlight SignColumn ctermbg=237
highlight Folded ctermbg=237
highlight StatusLine cterm=BOLD ctermfg=4 ctermbg=237 guifg=DarkBlue guibg=LightGrey
highlight ALEErrorSign guifg=Red guibg=NONE ctermbg=237 ctermfg=203
highlight ALEError guifg=255 guibg=203 ctermbg=203 ctermfg=255
highlight Visual ctermbg=239
highlight Search ctermbg=240
highlight Pmenu ctermfg=231 ctermbg=239
highlight airline_tabsel ctermbg=250

" CtrlP configuration
let g:ctrlp_working_path_mode = 'r' " Use nearest .git directory as cwd
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Do syntax highlighting
syntax on

" Always display status line
set laststatus=2

" Airline settings
let g:airline_theme='minimalist'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" Hide default mode text (ie. -- INSERT -- )
set noshowmode

" Buffer settings (buffers as tabs)
set hidden
nmap <leader>T :enew<cr>
nmap gt :bnext<CR>
nmap gT :bprevious<CR>

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

if has("macunix")
    set clipboard=unnamed
endif

" Only do if compiled with support for autocommands.
if has("autocmd")
    " Enable file type detection and language-dependent indentation.
    filetype plugin indent on

    " Automagically load .vimrc source when saved
    "autocmd BufWritePost .vimrc source $MYVIMRC

    " Jump to last known cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \    exe "normal g'\"" |
    \ endif

else
    set autoindent
endif
