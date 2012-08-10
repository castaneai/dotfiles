" NeoBundleを使うための準備
set nocompatible
filetype off
filetype plugin indent off
if has('vim_starting')
	set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
	call neobundle#rc(expand('$HOME/.vim/bundle/'))
endif

" NeoBundleのプラグインリスト
" プラグイン管理システム NeoBundle
NeoBundle 'Shougo/neobundle.vim'
" unite （ファイラ？）
NeoBundle 'Shougo/unite.vim'
" 単語補完
NeoBundle 'Shougo/neocomplcache'
" スニペット
NeoBundle 'Shougo/neocomplcache-snippets-complete'
" スムーズスクロール
NeoBundle 'Smooth-Scroll'
" 高級なステータスライン
NeoBundle "Lokaltog/vim-powerline"
" Zen-Coding (htmlタグ入力支援)
NeoBundle "mattn/zencoding-vim"
" カラースキーマ
NeoBundle "nanotech/jellybeans.vim"
" coffeescriptへの対応
NeoBundle "kchmck/vim-coffee-script"
" hamlへの対応
NeoBundle "tpope/vim-haml"
" LESSへの対応
NeoBundle "groenewege/vim-less"
" Stylusへの対応
NeoBundle "wavded/vim-stylus"
" インデントガイド
NeoBundle "nathanaelkane/vim-indent-guides"
" 設定ファイルを編集するショートカット
nnoremap <silent> <Leader>v :tabnew $MYVIMRC<CR>

" 設定ファイルを保存時に自動リロードする
augroup myvimrc
	au!
	au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc source $MYVIMRC | if has('gui_running') | source $MYGVIMRC | endif
augroup END

" CoffeeScriptを保存時に自動コンパイルする
" autocmd BufWritePost *.coffee silent CoffeeMake! -cb | cwindow | redraw!
" ↑silentをつけるとquickfixが勝手に閉じられる。なぜだ？今のところ原因不明なのでsilentを消しておく。
" autocmd BufWritePost *.coffee CoffeeMake! -cb | cwindow | redraw!

" 現在の行をハイライトする
set cursorline
" かれんとウィンドウのみにカーソルラインを引く
augroup cch
	autocmd! cch
	autocmd WinLeave * set nocursorline
	autocmd WinEnter,BufRead * set cursorline
augroup END

"highlight clear CursorLine
"highlight CursorLine gui=underline
"highlight CursorLine ctermbg=black guibg=black
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

" 文字セット
set fileformats=unix,dos,mac
set encoding=utf-8

" モードライン（ファイル中のvim:コメントによりvimの設定を制御する機能）
" set modeline
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
colorscheme jellybeans
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

" vim起動時にneocomplcacheを有効にする
let g:neocomplcache_enable_at_startup=1

" uniteは入力モードで開始する
let g:unite_enable_start_insert=0
" uniteはESCを2回押すと終了する
au FileType unite noremap <silent> <buffer> <Esc><Esc> :q<CR>

" スニペットのキーマッピングを設定
imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)

" 保管ウィンドウのキーマッピング
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1
let g:indent_guides_start_level=2
