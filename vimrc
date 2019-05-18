" Use Vim settings rather than Vi
set nocompatible


" Minpac setup ----------
set packpath^=~/.vim
packadd minpac
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})

call minpac#add('dikiaap/minimalist') " colorscheme

call minpac#add('vim-airline/vim-airline') " statusline widgets
call minpac#add('vim-airline/vim-airline-themes')

call minpac#add('ctrlpvim/ctrlp.vim') " C-p fuzzy search
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

call minpac#add('roxma/nvim-yarp')
call minpac#add('ncm2/ncm2') " tab completion
call minpac#add('ncm2/ncm2-jedi') " python completion
call minpac#add('ncm2/ncm2-tern', {'do': 'npm install'}) " javascript completion


call minpac#add('tmhedberg/SimpylFold') " Python code folding
call minpac#add('pangloss/vim-javascript') " javascript highlighting
call minpac#add('mxw/vim-jsx') " jsx highlighting

call minpac#add('aquach/vim-http-client') " REST client

call minpac#add('w0rp/ale') " syntax checking

packloadall

command! PluginInstall call minpac#update()
command! PluginClean call minpac#clean()
command! PluginList echo minpac#getpackages()

" VIM settings ----------
set t_Co=256 " 256 colors
set laststatus=2 " Always display status line
set ttimeoutlen=50 " Shorten pause when leaving insert mode
set noshowmode " Hide default mode text (ie. -- INSERT -- )
set incsearch " Perform search as you type
set backspace=2 " Backspace over anything
set lazyredraw
set ruler " Always show cursor position
set mouse=a " Scroll Vim with mouse
let g:python3_host_prog = '/Users/thoma/.virtualenvs/nvim/bin/python3'

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

" Jump to last known cursor position when opening file
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
    \ 	exe "normal g'\"" |
    \ endif

" Wildmenu (vim command tab completion)
set wildmenu
set wildmode=longest:full,full
set wildignore+=.git,*/node_modules/*,*/deps/build/*,*/stack/*,*/deps/go/*,*/deps/node/*,*/_site/*

" Buffer settings (buffers as tabs)
set hidden
nmap <leader>T :enew<cr>
nmap gt :bnext<CR>
nmap gT :bprevious<CR>

" Switch off wrapping
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

" Colors ----------
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

" Syntax + indentation ----------
syntax on
filetype plugin indent on
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd Filetype cpp setlocal shiftwidth=2 tabstop=2

" Mapped commands ----------
map <F2> :syntax sync fromstart<CR>

" w!! to force write file
cmap w!! w !sudo tee % >/dev/null

" jj to leave Insert mode
imap jj <Esc>

" Shift-Q to run last macro
nnoremap Q @@

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

" Plugin configuration ----------
" ncm2 settings
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
set shortmess+=c
inoremap <c-c> <ESC>
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"  'on_complete': ['ncm2#on_complete#delay', 180,
"               \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
au User Ncm2Plugin call ncm2#register_source({
        \ 'name' : 'css',
        \ 'priority': 9,
        \ 'subscope_enable': 1,
        \ 'scope': ['css','scss'],
        \ 'mark': 'css',
        \ 'word_pattern': '[\w\-]+',
        \ 'complete_pattern': ':\s*',
        \ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
        \ })


" Airline settings
let g:airline_theme='minimalist'
let g:airline_powerline_fonts = 1
let g:airline_minimalist_showmod = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

let g:airline#extensions#ale = 1
let g:airline#extensions#ale#error_symbol = '⨉ '
let g:airline#extensions#ale#warning_symbol = '⚠ '

" Ale settings
let g:ale_linters = {'javascript': ['eslint'], 'python': ['pylint']}
let g:ale_fixers = {'cpp': ['clang-format'], 'javascript': ['eslint'], 'python': ['black', 'trim_whitespace', 'remove_trailing_lines']}
let g:ale_completion_enabled = 0

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

" Ctrl-P settings
let g:ctrlp_working_path_mode = 'r' " Use nearest .git directory as cwd
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Gutentags settings
let g:gutentags_project_root = ['setup.py', 'package.json']
let g:gutentags_cache_dir = '/Users/thoma/.tags'
map gD <C-]>

" Make it possible to close netrw buffers
autocmd FileType netrw setl bufhidden=wipe
