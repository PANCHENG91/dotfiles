let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
    Plug 'jiangmiao/auto-pairs'
    Plug 'vim-airline/vim-airline'
    Plug 'preservim/nerdtree'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension'  }
call plug#end()

" ============================== basic =================================
" Use the Solarized Dark theme
set background=dark
colorscheme solarized
let g:solarized_termtrans=1

" Make vim more useful
set nocompatible
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without bom
set encoding=utf-8 nobomb
" Change mapleader
let mapleader=" "
" Don't add empty newlines at the end of files
set binary
set noeol
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

" Don't create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable line numbers
set number
" Enable syntax highlighting
syntax on
" Highlight current line
set cursorline
" Make tabs as wide as two spaces
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4

" Smart indent
set si
set ai
set wrap
set cindent

" Show "invisible" characters
"set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
"set list
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" When searching try to be smart about cases
set smartcase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
" Enable mouse in all modes
set mouse=a
" Disable error bells
set noerrorbells
" Don't reset cursor to start of line when moving around
set nostartofline
" Show the cursor position
set ruler
" Don't show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it's being typed
set showcmd

" Smart way to move between windows
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" Close the current buffer
noremap <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
noremap <leader>ba :bufdo bd<cr>

noremap <leader>l :bnext<cr>
noremap <leader>h :bprevious<cr>

" Use relative line numbers
"if exists("&relativenumber")
"	set relativenumber
"	au BufReadPost * set relativenumber
"endif
" Start scrolling three lines before the horizontal window border
"set scrolloff=3
" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>
" Fast saving
noremap <leader>w :w!<cr>
" Fast quit
noremap <leader>q :q!<cr>
noremap <leader>wq :wq!<cr>

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype on
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
	" Treat .md files as Markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" =========================== inoremap ===============================
inoremap jk <Esc>


" =========================== useful tools ===========================
nnoremap <silent> <leader>gg :!lazygit<CR>

" ============================== plug =================================
" ------------------------------ coc ---------------------------------
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <C-j>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<C-j>" :
      \ coc#refresh()
inoremap <expr><C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" ------------------------------- nerdtree ----------------------------
nnoremap <leader>e :NERDTreeToggle<CR>


" ------------------------------- airline ----------------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
" 下一个缓冲区
nnoremap <S-h> :bn<CR>
" 上一个缓冲区
nnoremap <S-l> :bp<CR>

" ------------------------------- LeaderF ----------------------------
let g:Lf_WindowPosition = 'popup'
" don't show the help in normal mode
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline"  }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }
let g:Lf_ShortcutF = "<leader>ff"
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
