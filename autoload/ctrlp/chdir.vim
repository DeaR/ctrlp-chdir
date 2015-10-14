" Change the working directory extension for CtrlP
"
" Maintainer:   DeaR <nayuri@kuonn.mydns.jp>
" Last Change:  14-Oct-2015.
" License:      Vim License  (see :help license)

if exists('g:loaded_ctrlp_chdir') && g:loaded_ctrlp_chdir
  finish
endif
let g:loaded_ctrlp_chdir = 1

let s:ars = [
\ 's:maxdepth', 's:maxfiles', 's:compare_lim', 's:glob', 's:caching']

call add(g:ctrlp_ext_vars, {
\ 'init'      : 'ctrlp#chdir#init(' . join(s:ars, ',') . ')',
\ 'accept'    : 'ctrlp#chdir#accept',
\ 'lname'     : 'chdir',
\ 'sname'     : 'chd',
\ 'exit'      : 'ctrlp#chdir#exit()',
\ 'type'      : 'path',
\ 'specinput' : 1})

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

function! ctrlp#chdir#init(...)
  let s:cwd = getcwd()
  return insert(copy(call('ctrlp#dir#init', a:000)), '.')
endfunction

function! ctrlp#chdir#accept(mode, str)
  let cmd = exists('s:cmd') && s:cmd ? 'lchdir!' : 'chdir!'
  let path = a:mode == 'h' ?
  \ getcwd() : s:cwd.ctrlp#call('s:lash', s:cwd) . a:str
  if a:mode =~ 'e\|h'
    call ctrlp#exit()
  endif
  call ctrlp#setdir(path, cmd)
  if a:mode == 'v'
    silent! call ctrlp#statusline()
    call ctrlp#setlines(s:id)
    call ctrlp#recordhist()
    call ctrlp#prtclear()
  endif
endfunction

function! ctrlp#chdir#cmd(cmd)
  let s:cmd = a:cmd
  return s:id
endfunction

function! ctrlp#chdir#exit()
  unlet! s:cmd
endfunction
