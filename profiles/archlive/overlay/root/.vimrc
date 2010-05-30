set nocompatible " get out of horrible vi-compatible mode
filetype on " detect the type of file
set history=100 " How many lines of history to remember
set ffs=dos,unix,mac " support all three, in this order
filetype plugin indent on " load filetype plugins
set viminfo+=! " make sure it can save viminfo
set isk+=_,$,@,%,#,- " none of these should be word dividers, so make them not be

set nobackup " make backup file
set makeef=error.err " When using make, where should it dump the file

set et
set nu
set numberwidth=4 " minimum width to use for the number column,not a fix size
" Text Formatting/Layout
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set formatoptions+=mM " for charactors fold and patch
set ai " autoindent
set si " smartindent 
set cindent " do c-style indenting
set tabstop=4 " tab spacing (settings below are just to unify it)
set softtabstop=4 " unify
set shiftwidth=4 " unify 
set noexpandtab " real tabs please!
set nowrap " do not wrap lines  
set smarttab " use tabs at the start of a line, spaces elsewhere