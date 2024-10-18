" see /usr/share/vim/vim70/syntax/tex.vim
" see link in ~/.vimrc

  ab ITEM \begin{itemize}<CR>\item<CR>\item<CR>\end{itemize}<CR>
  ab EQ Eq.~(\ref{*})
  ab FIG Fig.~(\ref{*})

" ab ae' {\"a}  does not work inside words
  imap 'ae {\"a}
  imap 'Ae {\"A}
  imap 'ue {\"u}
  imap 'Ue {\"U}
  imap 'oe {\"o}
  imap 'Oe {\"O}
  imap 'sz {\ss}

  imap "ae ä
  imap "Ae Ä
  imap "ue ü
  imap "Ue Ü
  imap "oe ö
  imap "Oe Ö
  imap "sz ß

  ab FGR \begin{figure}[tbh]<CR>\
   \begin{center}<CR>\
   \includegraphics[width=1\linewidth,trim = l b r t, clip=true]{*}<CR>\
   \end{center}<CR>\
\caption{*} <CR>\
\label{*} <CR>\
\end{figure} <CR><CR>

  ab FGR* begin{figure*}[tbh]<CR>\
   \begin{center}<CR>\
   \includegraphics[width=1\textwidth,clip]{*}<CR>\
   \end{center}<CR>\
\caption{*} <CR>\
\label{*} <CR>\
\end{figure*} <CR><CR>

  ab ITEM begin{itemize}<CR>\
\item *<CR>\
\item *<CR>\
\end{itemize}

" -------------------------------------------------------------------- "
  set textwidth=68
" -------------------------------------------------------------------- "

" setting foldlevel high practcally disables folds
  set foldlevel=10
  set tabstop=4

  let b:comment_leader = '% ' 
" set comment_leader+='%%'

" formatoptions (default: tcq
" see :help formatoptions -> :help fo-table
"
"     +=t  autowrap text using textwidth (does not apply to comments)
"     +=c  auto-wrap comments using textwidth, inserting the current
"          comment leader automatically.
"     +=r  automatically insert the current comment leader after
"          hitting <Enter> in Insert mode.
"     +=o  automatically insert the current comment leader after
"          hitting 'o' or 'O' in Normal mode.
"
" set formatoptions=rol

" rewrap paragraph starting from cursor position
  map <C-Q> gq}         " NB! C-W is used to jump between split windows!
                        " NB! C-R is used to redu (after u(ndo))

" shortcut for cygtex: Ctrl+Shift+x works like a charm (same as in WinEdt)
" map tx :!wbtex -pdf %<CR> 

  map tx :!pdflatex -pdf %<CR> 
  map <C-X> :w<CR> :!pdflatex %<CR>
  imap <C-X> <Esc> :w<CR> :!pdflatex %<CR>

" %<.pdf replaces extension .tex by .pdf (!)
  map <silent> <F1> :!gv --watch %<.pdf & <CR>
  imap <silent> <F1> <Esc> :w<CR> :!gv --watch %<.pdf & <CR>

" Wb,Mar23,08
" map <C-T> :w<CR> :!latex %<CR> && kdvi --unique %<.dvi & <CR>
" imap <C-T> <Esc> :w<CR> :!latex %<CR> && kdvi --unique %<.dvi & <CR>

" Wb,Mar23,08
" map <F2> :w<CR> :!wbtex -ps %< <CR>
" imap <F2> <Esc> :w<CR> :!wbtex -ps %< <CR>

" somehow newlines are all messed up when calling this !??
" (similar for script wbtex above !??)
  map <F2> :w<CR> :!make %< <CR>
  imap <F2> <Esc> :w<CR> :!make %< <CR>

  if version >= 508 || !exists("did_tex_syntax_inits")
   let did_tex_syntax_inits = 1
   if version < 508
    command -nargs=+ HiLink hi link <args>
   else
    command -nargs=+ HiLink hi def link <args>
   endif
  endif

" let s:xyellow = exists("g:xyellow") ? g:xyellow : '#FFFF00' 

  hi Comment      ctermfg=DarkGreen
  hi Delimiter    ctermfg=DarkRed
  hi texInputFile ctermfg=DarkGray
  hi Statement    ctermfg=DarkCyan
  hi Special      ctermfg=DarkGray

" Basic TeX highlighting groups
  HiLink texCmdArgs		Number
  HiLink texCmdName		Statement
  HiLink texComment		Comment
  HiLink texDef			Statement
  HiLink texDefParm		Special
  HiLink texDelimiter		Delimiter
  HiLink texInput		Special
  HiLink texInputFile		Special
  HiLink texLength		Number
  HiLink texMath		Special
  HiLink texMathDelim		Statement
  HiLink texMathOper		Operator
  HiLink texNewCmd		Statement
  HiLink texNewEnv		Statement
  HiLink texOption		Number
  HiLink texRefZone		Special
  HiLink texSection		PreCondit
  HiLink texSpaceCodeChar	Special
  HiLink texSpecialChar		SpecialChar
  HiLink texStatement		Statement
  HiLink texString		String
  HiLink texTodo		Todo
  HiLink texType		Type
  HiLink texZone		PreCondit

  delcommand HiLink

