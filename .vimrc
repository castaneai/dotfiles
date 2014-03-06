" プラグイン管理のNeoBundleを起動
if has('vim_starting')
	set nocompatible
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" vimで非同期操作を可能にする, NeoBundleと連携可能
NeoBundle 'Shougo/vimproc', {
    \ 'build': {
    \   'mac': 'make -f make_mac.mak',
    \   'unix': 'make -f make_unix.mak',
    \ }}

" 補完
NeoBundle 'Shougo/neocomplete'

" HTMLを楽に書ける(zen-coding)
NeoBundle 'mattn/emmet-vim'

" HTML編集機能を総合的に強化（タグの自動インデントなど）
NeoBundle 'othree/html5.vim'

" 黒背景のカラースキーマ
NeoBundle 'nanotech/jellybeans.vim'

" ステータスバーを豪華にする
NeoBundle 'itchyny/lightline.vim'

" Ctrl+Pで他のファイルにジャンプする
" NeoBundle 'kien/ctrlp.vim'

" 自動文法チェッカー 文法チェックツールは各自入れる必要がある
" javascript => jshint
" c => gcc
NeoBundle 'scrooloose/syntastic'

" インデントガイド
NeoBundle 'nathanaelkane/vim-indent-guides'

" quickrun
NeoBundle 'thinca/vim-quickrun'

" Javascriptの少しかしこい補完
" NeoBundle 'marijnh/tern_for_vim', {
"    \ 'build': {
"    \   'others': 'npm install'
"    \}}

" javascriptシンタックス
NeoBundle 'pangloss/vim-javascript'

" NeoBundleを動かすのに必要
filetype plugin indent on

" vim起動時に未インストールのNeoBundleがあればプロンプトを出す
NeoBundleCheck

" ファイルの種類に応じてシンタックスハイライト
syntax on

" タブをスペースに展開する
set expandtab

" タブの幅
set tabstop=4
set softtabstop=4

" インデント移動や自動インデントの時にずらす幅
set shiftwidth=4

" 改行したときインデントを維持する
" {の後はインデントを追加する
set cindent

" カラースキーマを適用する
set t_Co=256
colorscheme jellybeans

" 行番号を表示
set number

" ステータスバーを表示
set laststatus=2

" Backspaceキーで行頭・Tab文字などを消せる
set backspace=start,eol,indent

" スワップファイルを作成しない
set noswapfile
set nobackup

" 改行時にコメントの/*や"を引き継がないようにする（うざいから）
autocmd Filetype * set formatoptions-=r

" vimrcを保存したとき自動的に再読み込み
augroup myvimrc
	au!
	au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc source $MYVIMRC | if has('gui_running') | source $MYGVIMRC | endif
augroup END

" vimのコマンド補完を使いやすく
set wildmode=longest:full,full

" 左右のカーソル移動で行間を移動できるようにする
set whichwrap=b,s,<,>,[,]

" Ctrl + L で次のタブに切り替え
nnoremap <silent> <C-l> :tabnext<CR>
" Ctrl + H で前のタブに切り替え
nnoremap <silent> <C-h> :tabprevious<CR>

"
" neocomplete
" 

" neocompleteを起動時にONにする
let g:neocomplete#enable_at_startup = 1

" 自動補完を開始する最低の文字数
let g:neocomplete#auto_completion_start_length = 3

" fuzzy補完をOFF
let g:neocomplete#enable_fuzzy_completion = 0

" <Tab>で補完選択
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

"
" lightline
"
let g:lightline = {
			\ 'colorscheme': 'jellybeans',
			\ }

"
" indent-guides
"
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size= 1

"
" quickrun
" 
" F5キーでquickrun実行
nnoremap <silent> <F5> :QuickRun -mode n<CR>
vnoremap <silent> <F5> :QuickRun -mode v<CR>
" 出力をUTF-8にする
let g:quickrun_config = {
            \   "hook/output_encode/enable": 1,
            \   "hook/output_encode/encoding": "utf-8",
            \}
