#!/bin/bash

code_pkgs=(
    emacs emacs-common-non-dfsg # emacs info files
)

sudo apt install ${code_pkgs[*]}

./dotfiles/.emacs # install emacs packages

# following the example at
# https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/
BASEDIR="$(pwd)/dotfiles"
ln -sf ${BASEDIR}/.emacs ~/.emacs
