let s:noplugin = 0
let s:bundle_root = expand('~/.vim/bundle')
let s:neobundle_root = s:bundle_root . '/neobundle.vim'
if !isdirectory(s:neobundle_root) || v:version < 702
    " NeoBundleが存在しないまたはvimのバージョンが古い場合はneobundle読み込まない
    let s:noplugin = 1
else
    " プラグイン管理のNeoBundleを起動
    if has('vim_starting')
        set nocompatible
        execute "set runtimepath+=" . s:neobundle_root
    endif
    call neobundle#rc(expand('~/.vim/bundle/'))

    NeoBundleFetch 'Shougo/neobundle.vim'

    " vimで非同期操作を可能にする, NeoBundleと連携可能
    NeoBundle 'Shougo/vimproc', {
        \ 'build': {
        \   'windows': 'make -f make_mingw32.mak',
        \   'cygwin': 'make -f make_cygwin.mak',
        \   'mac': 'make -f make_mac.mak',
        \   'unix': 'make -f make_unix.mak',
        \ }}

    " 補完
    if has('lua') && ( (v:version >= 703 && has('patch885')) || v:version >= 704)
        NeoBundle 'Shougo/neocomplete'
        let g:neocomplete#enable_at_startup = 1
    else
        NeoBundle 'Shougo/neocomplcache'
        let g:neocomplcache_enable_at_startup = 1
    endif

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

    " 保存時に文法をチェックしてくれる
    " 文法チェックツールは各自入れる必要がある
    " javascript => npm install -g jshint
    " c => gcc
    NeoBundle 'scrooloose/syntastic'

    " インデントガイド
    NeoBundle 'nathanaelkane/vim-indent-guides'

    " quickrun
    NeoBundle 'thinca/vim-quickrun'

    " Javascriptの少しかしこい補完
    if has('python') && executable('npm')
        NeoBundleLazy 'marijnh/tern_for_vim', {
                    \ 'build': 'npm install',
                    \ 'autoload': {
                    \ 'functions': ['tern#Complete', 'tern#Enable'],
                    \ 'filetypes': 'javascript'
                    \ }}
    endif

    " javascriptシンタックス
    NeoBundle 'pangloss/vim-javascript'

    " NeoBundleを動かすのに必要
    filetype plugin indent on

    " vim起動時に未インストールのNeoBundleがあればプロンプトを出す
    NeoBundleCheck

endif

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

" 右端で折り返す
set wrap

" 80文字目にラインをいれる
set colorcolumn=80

" 不可視文字をunicodeでオサレに表示
set list
set listchars=tab:»\ 

" 入力モードでjjと押すとESCとみなす
inoremap jj <Esc>

" ESCを2回押すとハイライト削除
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" Ctrl + L で次のタブに切り替え
nnoremap <silent> <C-l> :tabnext<CR>
" Ctrl + H で前のタブに切り替え
nnoremap <silent> <C-h> :tabprevious<CR>

" j,kの移動を折り返された行でも自然に
nnoremap j gj
nnoremap k gk

" vを2回押すと行末まで選択
vnoremap v $h

" w!!で管理者として保存(sudoer限定)
cmap w!! w !sudo tee > /dev/null %

" 補完の設定
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
