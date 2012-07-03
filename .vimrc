" NeoBudleを使うための準備
set nocompatible
filetype off
filetype plugin indent off
if has('vim_starting')
	set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
	call neobundle#rc(expand('$HOME/.vim/bundle/'))
endif

" NeoBundleのプラグインリスト
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Smooth-Scroll'
NeoBundle "Lokaltog/vim-powerline"
NeoBundle "mattn/zencoding-vim"

" 現在の行をハイライトする
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
" スクロール時の余白を確保
set scrolloff=5

" 自動折り返しをしない
set textwidth=0

" バックアップ、スワップファイルを作らない
set nobackup
set noswapfile

" バックスペースで様々な文字を消せる
set backspace=indent,eol,start

" Beep音を無効化
set vb t_vb=

" カーソルが行頭行末で止まらない
set whichwrap=b,s,h,l,<,>,[,]

" コマンド、モードをステータスラインに表示
set showcmd
set showmode

" OSのクリップボードを使う
set clipboard+=unnamed
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
" ----------------------------------------------------
" Tab
" ----------------------------------------------------
nnoremap <Leader>t :tabnew<CR>
nnoremap <C-l> :tabn<CR>
nnoremap <C-h> :tabp<CR>
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
