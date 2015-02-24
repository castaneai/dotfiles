" vim-tinyやvim-smallの場合はvimrcの設定を読み込まない
if !1 | finish | endif

" autocmdはリロードされるたびに追加なのでリセットするように
" 以後すべてのautocmdにはグループ名を必ずつけること
augroup MyAutoCmd
    autocmd!
augroup END

" NeoBundleの準備
let s:noplugin = 0
let s:bundle_root = expand('~/.vim/bundle')
let s:neobundle_root = s:bundle_root . '/neobundle.vim'

" Neobundleが存在しない場合はプラグイン関連のことをしない
if !isdirectory(s:neobundle_root) || v:version < 702
    let s:noplugin = 1
else
    if has('vim_starting')
        set nocompatible
        set runtimepath+=~/.vim/bundle/neobundle.vim/
    endif
    call neobundle#begin(expand('~/.vim/bundle/'))
    NeoBundleFetch 'Shougo/neobundle.vim'

    " vimで非同期操作を可能にする, NeoBundleを使う場合入れることが推奨されている
    NeoBundle 'Shougo/vimproc', {
        \ 'build': {
        \   'windows': 'make -f make_mingw32.mak',
        \   'cygwin': 'make -f make_cygwin.mak',
        \   'mac': 'make -f make_mac.mak',
        \   'unix': 'make -f make_unix.mak',
        \ }}

    " 補完
    " neocompleteは新しいが、Luaなどの条件が必要なので満たさない場合はneocomplcacheにする
    " 普段は大文字小文字を区別しないが、大文字が含まれると区別するようにする
    if has('lua') && ( (v:version >= 703 && has('patch885')) || v:version >= 704 )
        NeoBundle 'Shougo/neocomplete'
        let g:neocomplete#enable_at_startup = 1
        let g:neocomplete#enable_ignore_case = 1
        let g:neocomplete#enable_smart_case = 1
    else
        NeoBundle 'Shougo/neocomplcache'
        let g:neocomplcache_enable_at_startup = 1
        let g:neocomplcache_enable_ignore_case = 1
        let g:neocomplcache_enable_smart_case = 1
    endif

    " HTMLを楽に書ける(zen-coding)
    NeoBundle 'mattn/emmet-vim'
    " emmet設定 (langをjaに、htmlタグ以外を展開しない)
    let g:user_emmet_settings = {
        \ 'lang': 'ja',
        \ 'html': {'filters': 'html'}
        \ }
    " Tabキーでemmet実行
    autocmd MyAutoCmd FileType html imap <buffer><expr><tab>
        \ emmet#isExpandable() ? "\<plug>(emmet-expand-abbr)" :
        \ "\<tab>"

    " HTML支援 (html indentが賢くなる)
    NeoBundle 'othree/html5.vim'

    " ステータスバーを豪華にする
    NeoBundle 'itchyny/lightline.vim'

    " Coffee script
    NeoBundle 'kchmck/vim-coffee-script'
    autocmd MyAutoCmd FileType coffee setlocal sw=2 ts=2 sts=2 expandtab

    " 保存時に文法をチェックしてくれる
    " 文法チェックツールは各自入れる必要がある
    " javascript => npm install -g jshint
    " c => gcc
    NeoBundle 'scrooloose/syntastic'

    " javascript支援 (javascript indentが賢くなる)
    NeoBundleLazy 'pangloss/vim-javascript', {
        \ 'autoload': {'filetypes': ['javascript']}
        \ }

    " javascriptのかしこい補完
    if has('python') && executable('npm')
        NeoBundleLazy 'marijnh/tern_for_vim', {
            \ 'build': {'others': 'npm install'},
            \ 'autoload': {'filetypes': ['javascript', 'typescript']}
            \ }
        " --INSERT-- という表示を消して現在入力中の引数説明が見えるようにする
        " コマンド入力欄の部分の表示が消えるだけで、airlineにはちゃんと表示されるので大丈夫 
        set noshowmode
        " 現在入力中の引数説明を表示
        let g:tern_show_argument_hints = 'on_move'
        " 関数の引数、返り値も補完に表示する
        let g:tern_show_signature_in_pum = 1
    endif

    " インデントガイド表示
    " TabではなくSpace文字でのインデントにもガイドを付けてくれる
    NeoBundle 'Yggdroot/indentLine'
    let g:indentLine_faster = 1
    let g:indentLine_color_term = has("mac") ? 239 : 8

    " JSONシンタックス
    NeoBundle 'elzr/vim-json'
    " jsonの文字列を囲むクォートを隠すのをやめる
    let g:vim_json_syntax_conceal = 0
    " indentLineをjsonでも表示されるようにする
    let g:indentLine_noConcealCursor=""

    " Ctrl + / でコメントアウト切り替え
    NeoBundle 'tyru/caw.vim'
    nmap <C-_> <Plug>(caw:i:toggle)
    vmap <C-_> <Plug>(caw:i:toggle)

    " Golang
    NeoBundle 'nsf/gocode'

    " Golang gd で定義元にジャンプする
    NeoBundle 'dgryski/vim-godef'
    " 新しいタブで定義元を開く
    let g:godef_split=2

    " golang強化
    NeoBundle 'vim-jp/vim-go-extra'
    " golang 保存時に自動でFmt
    autocmd MyAutoCmd FileType go autocmd BufWritePre <buffer> Fmt

    " quickrun
    NeoBundle 'thinca/vim-quickrun'
    " vimprocで非同期実行
    " 結果は下ウィンドウに5行の高さで表示
    let g:quickrun_config = {
        \ "_": {
        \   "runner": "vimproc",
        \   "runner/vimproc/updatetime": 60,
        \   "outputter/buffer/split": "rightbelow 5sp",
        \   "outputter/error/error": "quickfix",
        \   "outputter/error/success": "buffer",
        \   "outputter": "error"
        \ },
    \}
    " Ctrl+Cでquickrunの実行中止
    nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
    " Ctrl+Xでメインウィンドウ以外を閉じる
    nnoremap <silent> <C-x> :only<CR>
    " F5でquickrun実行
    nnoremap <silent><F5> :QuickRun -mode n<CR>

    " アセンブリのシンタックス
    NeoBundle 'shiracamus/vim-syntax-x86-objdump-d'

    " カラースキーマ
    NeoBundle 'chriskempson/vim-tomorrow-theme'
    NeoBundle 'wombat256.vim'

    call neobundle#end()

    " vim起動時に未インストールのNeoBundleがあればプロンプトを出す
    NeoBundleCheck
endif

" ファイルの種類に応じてシンタックスハイライト
filetype plugin indent on
syntax enable

" カラースキーマ
if !has('gui_running')
    set t_Co=256
endif
if s:noplugin
    colorscheme default
else
    colorscheme wombat256mod
endif

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

" 行番号を表示
set number

" ステータスバーを表示
set laststatus=2

" Backspaceキーで行頭・Tab文字などを消せる
set backspace=start,eol,indent

" 邪魔な一時ファイルを作成しない
set noswapfile
set nobackup

" 改行時にコメントの/*や"を引き継がないようにする（うざいから）
autocmd MyAutoCmd Filetype * setlocal formatoptions-=ro

" vimのコマンド補完を使いやすく
set wildmode=longest:full,full

" 左右のカーソル移動で行間を移動できるようにする
set whichwrap=b,s,<,>,[,]

" 右端で折り返す
set wrap

" 不可視文字をunicodeでオサレに表示
set list
set listchars=tab:»\ 
" 不可視文字の背景色が変えられてしまうのを回避
autocmd MyAutoCmd VimEnter,ColorScheme * hi SpecialKey ctermbg=NONE

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

" neocomplete 補完の設定
" <Tab>で補完選択
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" マウスでスクロール可能にする
" ノーマルモードでしかスクロールは基本しないのでノーマルモードの時のみ有効にする
set mouse=n

" html, ruby, yaml関連はタブ幅2
autocmd MyAutoCmd BufRead,BufNewFile Gemfile,Rakefile,*.rake set ft=ruby
autocmd MyAutoCmd FileType ruby,html,yaml set sw=2 sts=2 ts=2 expandtab

" omni補完
" javascriptのomni補完はternが自動的に有効にしてくれるのでココには書かない
autocmd MyAutoCmd FileType scss,css setlocal omnifunc=csscomplete#CompleteCSS
autocmd MyAutoCmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags

" vim scriptの \ による行連結の追加インデント量を指定
" デフォルトでは &sw * 3と3インデント分で嫌だったので&swに
let g:vim_indent_cont = &sw

" 検索・コマンド補完時に大文字小文字区別しない
set ignorecase
set smartcase

" OSのクリップボードを使う
set clipboard& clipboard+=unnamed

" スクリーンベルを鳴らさない
set t_vb=
set novisualbell

" □や○をずれないように
set ambiwidth=double

" コマンド補完を豪華に
set wildmenu

" 現在の行をハイライト
set cursorline

" 新しいウィンドウを右または下に追加する
set splitright
set splitbelow

" スクロールの余白を確保
" 一番下までいってからスクロールが起こると下に何があるか見難いので
" ３行前からスクロールを始める
set scrolloff=3
