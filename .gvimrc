source $HOME/.vimrc
" フォント設定
" 英文字はInconsolata, 日本語などのワイド文字はMeiryoKe_Gothicを使う
set guifont=Inconsolata:h11 guifontwide=MeiryoKe_Gothic:h11
" 斜体文字（イタリック）を無効にする
set guioptions-=T
" ウィンドウのサイズ
set lines=40
set columns=120

" ウィンドウサイズの記憶
let g:save_window_file = expand('~/.vimwinpos')
augroup SaveWindow
  autocmd!
  autocmd VimLeavePre * call s:save_window()
  function! s:save_window()
    let options = [
      \ 'set columns=' . &columns,
      \ 'set lines=' . &lines,
      \ 'winpos ' . getwinposx() . ' ' . getwinposy(),
      \ ]
    call writefile(options, g:save_window_file)
  endfunction
augroup END

if filereadable(g:save_window_file)
  execute 'source' g:save_window_file
endif
