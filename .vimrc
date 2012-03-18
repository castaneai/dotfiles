set nocompatible
filetype plugin indent off

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim/
	call neobundle#rc(expand('~/.vim/bundle/'))
endif

NeoBundle 'Shougo/neobundle.vim'
"NeoBundle 'Shougo/vimproc'
"NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
"NeoBundle 'smooth_scroll.vim'
NeoBundle "ZenCoding.vim"
NeoBundle "Lokaltog/vim-powerline"


"Bundle 'gmarik/vundle'
"Bundle 'ZenCoding.vim'
"Bundle 'surround.vim'
"Bundle 'neocomplcache'
"Bundle 'Shougo/git-vim'
"Bundle 'thinca/vim-quickrun'
"Bundle 'unite.vim'
"Bundle 'cakebaker/scss-syntax.vim'
"Bundle 'html5.vim'
"Bundle 'Shougo/vimproc'
"Bundle 'avakhov/vim-yaml'
"Bundle 'vim-coffee-script'
"Bundle 'lunaru/vim-twig'
"Bundle 'beyondwords/vim-twig'
" ----------------------------------------------------
" Highlight cursor line
" ----------------------------------------------------
set cursorline
" Only current window highlighting
augroup cch
	autocmd! cch
	autocmd WinLeave * set nocursorline
	autocmd WinEnter,BufRead * set cursorline
augroup END

:hi clear CursorLine
:hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black
" ----------------------------------------------------
" Move tabs with <C-hjkl>
" ----------------------------------------------------
nnoremap <C-l> :tabn<CR>
nnoremap <C-h> :tabp<CR>

set scrolloff=5
set textwidth=0

set nobackup
set noswapfile

set backspace=indent,eol,start
set vb t_vb=
set whichwrap=b,s,h,l,<,>,[,]
set showcmd
set showmode
" ----------------------------------------------------
" FileType
" ----------------------------------------------------
filetype plugin on
filetype indent on

autocmd FileType html,twig,yaml setlocal tabstop=2 shiftwidth=2
autocmd FileType yaml setlocal expandtab
" ----------------------------------------------------
" StatusLine 
" ----------------------------------------------------
set laststatus=2
set ruler
" ----------------------------------------------------
" Appearance
" ----------------------------------------------------
set showmatch
set number
set display=uhex
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/
set cursorline
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END
:set lazyredraw
:set ttyfast
" ----------------------------------------------------
" Tab
" ----------------------------------------------------
nnoremap <Leader>t :tabnew<CR>
" ----------------------------------------------------
" Indent
" ----------------------------------------------------
set autoindent
set smartindent
set cindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set smarttab
" ----------------------------------------------------
" Colors
" ----------------------------------------------------
syntax enable
colorscheme zenburn
set t_Co=256
" ----------------------------------------------------
" Edit
" ----------------------------------------------------
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
inoremap , ,<Space>
set hlsearch
set incsearch
set showmatch
set ignorecase
set smartcase
set nowrapscan
set title
set wildmenu
" ----------------------------------------------------
" Plugins
" ----------------------------------------------------
noremap <silent> <C-P> :Unite file_rec -default-action=tabopen<CR>

let g:neocomplcache_enable_at_startup=1
