" Vim syntax file
" adaptet from conf.vim -- Wb,Sep23,08

" Language:	generic txtigure file
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2005 Jun 20

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn keyword	txtTodo	contained TODO FIXME XXX
" Avoid matching "text#text", used in /etc/disktab and /etc/gettytab
syn match	txtComment	"^#.*" contains=txtTodo
syn match	txtComment	"\s#.*"ms=s+1 contains=txtTodo
syn region	txtString	start=+"+ skip=+\\\\\|\\"+ end=+"+ oneline
syn region	txtString	start=+'+ skip=+\\\\\|\\'+ end=+'+ oneline

" Define the default highlighting.
" Only used when an item doesn't have highlighting yet
hi def link txtComment	Comment
hi def link txtTodo	Todo
hi def link txtString	String

  let b:current_syntax = "txt"

" let b:comment_leader = '% ' 
" let b:comment_leader ='// ' 

" vim: ts=8 sw=2
