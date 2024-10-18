" ~/.vim/matlab.vim
" Author: Matt Corks <mvcorks [AT] alumni [dot] uwaterloo [dot] ca>
"
" See also /usr/share/vim/vim71/syntax/matlab.vim

  ab mhe eval(['help ' mfilename]);

  ab wbE error('Wb:ERR','\n   ERR invalid usage');
  ab wbW warning('Wb:WRN','invalid usage');

  ab wbe wblog('ERR','');
  ab wbt wblog('TST','');
  ab wbw wblog('WRN','');
  ab wbi wblog('<i>','');
  ab wbn wblog('NB!','');
  ab wbl wblog(' * ','');

  ab mfi mfilename
  ab MFI strrep(mfilename,'_','\_')

  ab sma ah=smaxis(2,2,'tag',mfilename); header('%M'); addt2fig Wb<CR>setax(ah(1,1))<CR>

" syntax highlighting
  if has("gui_running")
  " looks for global variable VIM to be defined!!??
    if exists("colour_xterm")
      source $VIM/syntax/syntax.vim
    endif
  endif

" NB! <C-z> sets vi-session into background (like ctrl-z on bash)

"  map <C-Q> :split $MLIB/abc.m <CR>
   map <C-Q> :tabnew $MLIB/abc.m <CR>
  imap <C-Q> <Esc> :tabnew $MLIB/abc.m <CR>

" edit this file
  map ;E :e $HOME/.vim/matlab.vim<CR>

" check syntax
  map ;s :" Sorry, no syntax checker for matlab(1) files<CR>

" comments
  map ;c mz0i%<ESC>`z
  map ;C mz0x`z
  vmap ;c <ESC>:'<,'>s/^/%/<CR>'<
  vmap ;C <ESC>:'<,'>s/^%//<CR>'<

" title block
   map ;t :set paste<CR>O<ESC>40a%<ESC>jI% <ESC>o<ESC>40a%<ESC>k0W:set nopaste<CR>
  vmap ;t <ESC>:'<,'>s/^/% /<CR>'<O<ESC>40a%<ESC>'>o<ESC>40a%<ESC>'<j0W

  set cinkeys=0{,0},:,0%,!^F,o,O
  set cinwords={
  set formatoptions=croql cindent comments=b:%

  set keywordprg=man

    map ;h :"<CR>
  unmap ;h
    map ;H :"<CR>
  unmap ;H
    map ;m :"<CR>
  unmap ;m
    map ;M :"<CR>
  unmap ;M
    map ;N :"<CR>
  unmap ;N

  set equalprg=matlab

