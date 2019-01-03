" Use Vim settings rather than Vi
set nocompatible
filetype off

set packpath^=~/.vim
packadd minpac
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})

call minpac#add('dikiaap/minimalist') " colorscheme

call minpac#add('vim-airline/vim-airline') " statusline widgets
call minpac#add('vim-airline/vim-airline-themes')

call minpac#add('ctrlpvim/ctrlp.vim') " C-p fuzzy search
call minpac#add('majutsushi/tagbar') " \t to view ctags
call minpac#add('ludovicchabant/vim-gutentags') " tag management

call minpac#add('jeetsukumaran/vim-buffergator') " \b to view open buffers
call minpac#add('justinmk/vim-dirvish') " path navigator (trigger via '-')
call minpac#add('ntpeters/vim-better-whitespace') " makes trailing whitespace red

call minpac#add('tpope/vim-fugitive') " git commands within vim
call minpac#add('tpope/vim-git') " syntax files for git

call minpac#add('Lokaltog/vim-easymotion') " file navigation \\w \\b
call minpac#add('christoomey/vim-tmux-navigator') " move between vim and tmux seamlessly
call minpac#add('tpope/vim-surround') " surround a word with something (ex: ysiw)
call minpac#add('scrooloose/nerdcommenter') " easy commenting
call minpac#add('ervandew/supertab') " tab completion

call minpac#add('tmhedberg/SimpylFold') " Python code folding
call minpac#add('pangloss/vim-javascript') " javascript highlighting
call minpac#add('mxw/vim-jsx') " jsx highlighting
"call minpac#add('digitaltoad/vim-pug') " syntax highlighting for pug templates

call minpac#add('aquach/vim-http-client') " REST client

call minpac#add('w0rp/ale') " syntax checking

packloadall

" minpac commands
command! PluginInstall call minpac#update()
command! PluginClean call minpac#clean()
command! PluginList echo minpac#getpackages()

" Always display status line
set laststatus=2

" Shorten pause when leaving insert mode
set ttimeoutlen=50

" Ignore things
set wildmenu
set wildmode=longest:full,full
set wildignore+=.git,*/node_modules/*,*/deps/build/*,*/stack/*,*/deps/go/*,*/deps/node/*,*/_site/*

" Airline settings
let g:airline_theme='minimalist'
let g:airline_minimalist_showmod = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#ignore_bufadd_pat = 'gundo|undotree|vimfiler|tagbar|nerd_tree|startify|!'

let g:airline#extensions#ale = 1
let g:airline#extensions#ale#error_symbol = '⨉ '
let g:airline#extensions#ale#warning_symbol = '⚠ '

" 256 colors, enable colorscheme
set t_Co=256
colorscheme minimalist " Must be set after enabling tabline

" Ale linter settings
let g:ale_linters = {'javascript': ['eslint'], 'python': ['pylint']}
let g:ale_fixers = {'cpp': ['clang-format'], 'javascript': ['eslint'], 'python': ['black', 'trim_whitespace', 'remove_trailing_lines']}

let g:ale_lint_on_text_changed = 'never'
let g:ale_python_pylint_change_directory = 0
let g:ale_fix_on_save = 1

let g:ale_sign_error = '⨉'
let g:ale_sign_warning = '∆'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '']

let g:ale_python_black_options = '-l 100'
let g:ale_c_clangformat_options = '-style="{BasedOnStyle: llvm, IndentWidth: 2, ColumnLimit: 100, AllowShortFunctionsOnASingleLine: None, KeepEmptyLinesAtTheStartOfBlocks: false}"'
map <F1> :ALEFix<CR>

" VIM http client settings
let g:http_client_result_vsplit = 0
let g:http_client_bind_hotkey = 0
let g:http_client_focus_output_window = 0
nnoremap <Leader>r :HTTPClientDoRequest<cr>

" Fix syntax highlighting
map <F2> :syntax sync fromstart<CR>

" Make it possible to close netrw buffers
autocmd FileType netrw setl bufhidden=wipe

" Change some colors
highlight SignColumn ctermbg=237
highlight Folded ctermbg=237
highlight StatusLine cterm=BOLD ctermfg=4 ctermbg=237
highlight ALEErrorSign ctermbg=237 ctermfg=203
highlight ALEError ctermbg=203 ctermfg=255
highlight ALEWarningSign ctermbg=237
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

" Hide default mode text (ie. -- INSERT -- )
set noshowmode

" Buffer settings (buffers as tabs)
set hidden
nmap <leader>T :enew<cr>
nmap gt :bnext<CR>
nmap gT :bprevious<CR>

" tags
nmap <leader>t :TagbarToggle<cr>
let g:gutentags_project_root = ['setup.py', 'package.json']
let g:gutentags_cache_dir = '/Users/thoma/.tags'
map gD <C-]>


" Switch off wrapping, proper indentation
set nowrap
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Code folding
set foldnestmax=3
set nofoldenable
set foldlevel=1
set foldmethod=syntax
nnoremap <Space> zA
autocmd FileType javascript syntax region foldBraces start=/{/ end=/}/ transparent fold keepend extend
autocmd FileType python set foldmethod=indent
let g:SimpylFold_docstring_preview = 1

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

set incsearch

" Backspace over anything
set backspace=2

" jj to leave Insert mode
imap jj <Esc>

" Always show cursor position
set ruler

" Macro stuff
nnoremap Q @@
set lazyredraw

" Scroll Vim with mouse
set mouse=a

if has("macunix")
    set clipboard=unnamed
endif

" Keep undo history across sessions by storing it in a file
if has("persistent_undo")
    let undo_dir = expand("$HOME/.vim/undo_dir")
    if !isdirectory(undo_dir)
        call mkdir(undo_dir, "", 0700)
    endif
    set undodir=$HOME/.vim/undo_dir
    set undofile
endif

" Enable file type detection and language-dependent indentation.
filetype plugin indent on
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd Filetype cpp setlocal shiftwidth=2 tabstop=2

" Automagically load .vimrc source when saved
"autocmd BufWritePost .vimrc source $MYVIMRC

" Jump to last known cursor position
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
    \ 	exe "normal g'\"" |
    \ endif
