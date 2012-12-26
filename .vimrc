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
" 高級なステータスライン
NeoBundle "Lokaltog/vim-powerline"
" Zen-Coding (htmlタグ入力支援)
NeoBundle "mattn/zencoding-vim"
" coffeescriptへの対応
NeoBundle "kchmck/vim-coffee-script"
" Stylusへの対応
NeoBundle "wavded/vim-stylus"
" jinja(Twig)への対応
NeoBundle "uggedal/jinja-vim"
" 編集中のスクリプトを実行する
NeoBundle "thinca/vim-quickrun"
" Markdownへの対応
NeoBundle "tpope/vim-markdown"

" カラースキーマ
NeoBundle "altercation/vim-colors-solarized"
set background=dark
colorscheme solarized
let g:solarized_italic=0

" 設定ファイルを編集するショートカット
nnoremap <silent> <Leader>v :tabnew $MYVIMRC<CR>
nnoremap <silent> <Leader>gv :tabnew $MYGVIMRC<CR>

" 設定ファイルを保存時に自動リロードする
augroup myvimrc
	au!
	au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc source $MYVIMRC | if has('gui_running') | source $MYGVIMRC | endif
augroup END

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
" OSのクリップボードを使う
set clipboard+=unnamed
" ファイルフォーマット
set fileformats=unix,dos,mac
" 文字セット
set encoding=utf-8
" モードライン（ファイル中のvim:コメントによりvimの設定を制御する機能）
set modeline
" 現在の行をハイライト
" ハイライトの色などはカラースキーマで決められている
set cursorline
set cursorcolumn
" ファイルタイプ
filetype plugin on
filetype indent on

autocmd FileType html,jinja,yaml setlocal tabstop=2 shiftwidth=2
autocmd FileType yaml setlocal expandtab
autocmd BufNewFile,BufRead *.twig setfiletype jinja
" 対応する括弧を強調表示
set showmatch
" 行番号を表示
set number
" 表示できない文字を16進数で表示
set display=uhex

" ファイル保存時存在しないディレクトリを自動生成する
augroup vimrc-auto-mkdir
    autocmd!
    autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
    function! s:auto_mkdir(dir, force)
        if !isdirectory(a:dir) && (a:force ||
            \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
            call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
        endif
    endfunction
augroup END
" ----------------------------------------------------
" Tab
" ----------------------------------------------------
" 常に上部にタブバーを表示する
set showtabline=2
"  \tで新規ドキュメントを新しいタブに作成する
nnoremap <Leader>t :tabnew<CR>
" Ctrl + L で次のタブに切り替え
nnoremap <C-l> :tabn<CR>
" Ctrl + H で前のタブに切り替え
nnoremap <C-h> :tabp<CR>
"  C言語ライクインデント
"  この機能にはautoindent, smartindentの機能も含まれている
set cindent
" <Tab>文字を見た目上で何文字分の幅に展開するか
set tabstop=4
" vimが挿入する<Tab>文字が何文字分の幅になるか
set shiftwidth=4
" Tabキーを入力した際に挿入される空白の量　0の場合tabstopと同じになる
set softtabstop=0
" シンタックスカラーリング
syntax enable
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
" カレントディレクトリ以下のファイルを参照できるUnite
noremap <silent> <C-P> :Unite file_rec -default-action=tabopen<CR>

" vim起動時にneocomplcacheを有効にする
let g:neocomplcache_enable_at_startup=1

" uniteは入力モードで開始する
let g:unite_enable_start_insert=1
" uniteはESCを押すと終了する
au FileType unite noremap <silent> <buffer> <Esc> :q<CR>

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

" <space>cdで現在開いているファイルのディレクトリに移動する
command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>') 
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
        pwd
    endif
endfunction

" Change current directory.
nnoremap <silent> <Space>cd :<C-u>CD<CR>
