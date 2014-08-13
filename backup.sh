#!/bin/bash

# echo Make sure you are running on cygwin@winxp...
# echo Press enter to continue, or Ctrl-C to exit.
# read

thecp=`which cp`
themv=`which mv`
therm=`which rm`
$thecp -f ~/.bashalias ./
$thecp -f ~/.gitconfig ./
$thecp -f ~/.vimrc ./
$thecp -f ~/.toprc ./
$thecp -f ~/.tmux.conf ./
$thecp -f ~/.pythonstartup ./

$thecp -f ~/.ssh/id_rsa.pub ./
$thecp -f ~/.ssh/id_dsa.pub ./

$themv -f ~/.vim/mytags ~/.vim.mytags
$thecp -r -f ~/.vim -t ./
$themv -f ~/.vim.mytags ~/.vim/mytags

$therm -rf ./.vim/bundle/vim-sensible/.git
$therm -rf ./.vim/.netrwhist

# $thecp -f ~/.gvimrc ./
# $thecp -f ~/.dircolors ./
# $thecp -f ~/.minttyrc ./
# $thecp -f ~/.inputrc ./
# $thecp -f ~/.bashaliascyg ./
# $thecp -f ~/.wgetrc ./
# $thecp -r -f ~/bin -t ./

