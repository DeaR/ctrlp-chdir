" Change the working directory extension for CtrlP
"
" Maintainer:   DeaR <nayuri@kuonn.mydns.jp>
" Last Change:  14-Oct-2015.
" License:      Vim License  (see :help license)

command! -nargs=? -complete=dir
\ CtrlPChdir
\ call ctrlp#init(ctrlp#chdir#cmd(0), {'dir' : <q-args>})
command! -nargs=? -complete=dir
\ CtrlPLchdir
\ call ctrlp#init(ctrlp#chdir#cmd(1), {'dir' : <q-args>})
