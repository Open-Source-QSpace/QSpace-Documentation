
" somehow newlines are all messed up when calling this !??
" (similar for script wbtex above !??)

" NB! C-x is used for line completion
"  map <C-x>       :w<CR> :!make %< <CR>
" imap <C-x> <Esc> :w<CR> :!make %< <CR>

  ab LOG printf("\n  %s:%d\n\n",__FILE__,__LINE__,);

  ab wbe wblog(FL,"ERR %s()",FCT);
  ab wbw wblog(FL,"WRN %s()",FCT);
  ab wbt wblog(FL,"TST %s()",FCT);
  ab wbl wblog(FL,"%s() ",FCT);
  ab wbi wblog(FL,"<i>");
  ab wbob wblog(FL,"ERR %s() index out of bounds (%d/%d)",FCT,,);

  ab mxp MXPut(FL,"ans").add(,"").add(,"").add(,"").add(,"");
  ab tnm getName(typeid(T)).data
 
  ab UNUSED __attribute__ ((unused))

