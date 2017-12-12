" Specify plugins with vim-plug
call plug#begin('~/.vim/plugged')

" Control spaces/tabs and indentation via editorconfig files
Plug 'editorconfig/editorconfig-vim'
" File explorer. Maybe remove? I don't use it...
Plug 'scrooloose/nerdtree'
" JavaScript syntax highlighting and indentation assistance
Plug 'pangloss/vim-javascript'
" Do I need this? Maybe? ihttps://github.com/pangloss/vim-javascript/issues/955
Plug 'mxw/vim-jsx'

" Include FZF
Plug '/usr/local/opt/fzf'
" Fuzzy File Finder to search through files in the directory tree via :Files
" Also includes :Ag to search file contents with Silver Search and display
" results in an FZF screen.
Plug 'junegunn/fzf.vim'

" Linting
Plug 'vim-syntastic/syntastic'

" Commenting and uncommenting code
Plug 'scrooloose/nerdcommenter'

" Monokai color scheme
Plug 'sickill/vim-monokai'

" Atom OneDark color scheme clone
Plug 'joshdick/onedark.vim'

" Asynchronous Lint Engine
" I can't use this until we update our ESLint dependencies, there's something
" wrong with them.
" Plug 'w0rp/ale'
call plug#end()

" Enable syntax highlighting
syntax on

colorscheme onedark

" Enable filetype detection and plugin/indentation loading
filetype plugin indent on

" Show invisible characters (tab, end of line) a la TextMate
set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list

let mapleader = ","

if !exists(':Vimrc')
  command Vimrc :vsplit $MYVIMRC
endif
if !exists(':Reload')
  command Reload :source $MYVIMRC
endif

" Allow backspace in insert mode
set backspace=indent,eol,start

" Disable arrow keys to force use of hjkl for navigation
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Status line includes
set statusline=%F\ %l,%v\ (%L\ lines)

" Enable line numbers
set number

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

" Copy opened file path to system clipboard
nnoremap <leader>cp :let @+ = expand("%:p")<CR>

" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch

" Open vertical splits on the right of the current window
set splitright

nnoremap <leader>f :Files<CR>

" Syntastic defaults
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
" Don't run syntax checking on quit
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers = ['eslint']
" Use local project's ESLint modules
let g:syntastic_javascript_eslint_exec = '~/bin/eslint-wrapper-for-vim-syntastic'

" Use vertical cursor in insert mode
" https://ttssh2.osdn.jp/manual/en/usage/tips/vim.html#CursorStyle
" Set cursor on entering insert mode
let &t_SI .= "\e[5 q"
" Set cursor on leaving insert mode
let &t_EI .= "\e[2 q"

" Automatically refresh buffers when the file changes outside of Vim (e.g. by `git checkout`, etc.)
set autoread

" Remove trailing whitespace on save
" http://vim.wikia.com/wiki/Remove_unwanted_spaces
autocmd BufWritePre * %s/\s\+$//e

" jk to exit insert mode
inoremap jk <esc>
" Disable esc to force usage of jk
inoremap <esc> <nop>

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Add familiar mapping Control-d to visually select the word under the cursor
nnoremap <c-d> viw

" Clear current search with /-Enter
nnoremap /<CR> :let @/ = ""<CR>

" Control-a to select all
nnoremap <c-a> ggVG

" Map Control-directional keys to navigate windows
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
