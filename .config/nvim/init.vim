set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.cache/dein'))

call dein#add('Shougo/dein.vim')

call dein#add('Shougo/deoplete.nvim')
let g:deoplete#enable_at_startup = 1
inoremap <silent><expr> <Tab>
\ pumvisible() ? "\<C-n>" :
\ deoplete#mappings#manual_complete()

inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
	return deoplete#close_popup() . "\<CR>"
endfunction<Paste>

call dein#end()

filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" 行番号
set number

" インデント
set cindent

" タブ幅
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" 検索などに大文字小文字区別しない
set ignorecase
