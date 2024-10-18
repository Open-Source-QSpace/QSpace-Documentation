" vim

" Vim syntax support file
" Maintainer: Bram Moolenaar <mool@oce.nl>
" Modified by: Matt Corks <mvcorks [AT] alumni [dot] uwaterloo [dot] ca>

" This is the startup file for syntax highlighting.
" It sets the default highlighting methods, and installs autocommands for all
" the available syntax files.

" I modify it so it only contains the languages I actually use.  I suggest you
" do the same, but start with the distribution $VIM/syntax/syntax.vim.

if has("syntax")
  
  if has("gui_running")

    if exists("colour_xterm")

      " The default methods for highlighting.  Can be overridden later.  There
      " should be only six of these, because many terminals can only use six
      " different colours (plus black and white).  It doesn't look nice with
      " too many colours too.
      highlight Comment term=bold ctermfg=4 guifg=Blue
      highlight Constant term=underline ctermfg=2 guifg=Magenta
      highlight Identifier term=underline ctermfg=2 guifg=LightSkyBlue
      highlight Statement start=t_md stop=t_me cterm=bold ctermfg=5 gui=bold guifg=Brown
      highlight PreProc term=underline ctermfg=1 guifg=Purple
      highlight Type term=underline ctermfg=2 guifg=SeaGreen gui=bold
      highlight Special term=bold ctermfg=6 guifg=SlateBlue gui=underline

      " These two change the background
      highlight Error term=reverse ctermbg=1 guibg=Orange
      highlight Todo term=standout ctermbg=3 guifg=Blue guibg=Yellow

      " Common groups that link to default highlighting.
      " You can specify other highlighting easily.
      highlight link String Constant
      highlight link Character Constant
      highlight link Number Constant
      highlight link Float Constant
      highlight link Function Identifier
      highlight link Conditional Statement
      highlight link Repeat Statement
      highlight link Label Statement
      highlight link Operator Statement
      highlight link Keyword Statement
      highlight link Include PreProc
      highlight link Define PreProc
      highlight link Macro PreProc
      highlight link PreCondit PreProc
      highlight link StorageClass Type
      highlight link Structure Type
      highlight link Typedef Type
      highlight link Tag Special

      " Syntax highlighting is local to a buffer, and doesn't need to be
      " undone after every BufLeave event.  The autocommands which load other
      " language specific files change global settings, and are unloaded.
      " However, the menus to pick a specific language just source my files,
      " so to be sure, the syntax stuff is loaded in them as well.  That means
      " it is redundant to have autocommands for them listed here as well.

    "  " C, C++
    "  au BufEnter *.c,*.cpp,*.cc,*.h,*.cxx,*.c++,*.C,*.H,*.hh,*.y,*.l source $VIM/syntax/cpp.vim
    "  " HTML
    "  au BufEnter *.html,*.htm source $VIM/syntax/html.vim
      " Java
      au BufEnter *.java source $VIM/syntax/java.vim
      " Makefile
      au BufEnter *.mak,[mM]akefile*,*.make source $VIM/syntax/make.vim
    "  " Perl
    "  au BufEnter *.pl,*.pm,*.PL source $VIM/syntax/perl.vim
    "  " Modula 3
    "  au BufEnter *.m3,*.mg,*.i3,*.ig source $HOME/.vim/modula3.vim
      " Shell script (until there is a csh.vim)
      au BufEnter .profile,.login,.cshrc,.bashrc source $VIM/syntax/sh.vim
      " Z-Shell script
      au BufEnter .z*,zsh*,zlog*,.zsh*,.zshrc source $VIM/syntax/zsh.vim
      " Tex
      au BufEnter *.tex source $VIM/syntax/tex.vim
      " Vim Help file
      au BufEnter */vim*/doc/*.txt source $VIM/syntax/help.vim
    "  " Vim script
    "  au BufEnter .*vimrc,.exrc,*.vim,*vimrc source $VIM/syntax/vim.vim
      " Various scripts, without a specific extension
      " (this should really load my language files as well)
      au BufEnter * source $VIM/syntax/scripts.vim

      " Execute these autocommands for each buffer currently loaded.
      doautoall BufReadPost


    endif " colour_xterm

  endif " gui_running

endif " syntax
