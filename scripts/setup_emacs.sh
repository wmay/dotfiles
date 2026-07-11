#!/bin/bash

code_pkgs=(
    emacs emacs-common-non-dfsg # emacs info files
)

sudo apt install ${code_pkgs[*]}

./.emacs # install emacs packages

# following the example at
# https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ln -sf ${BASEDIR}/.emacs ~/.emacs
