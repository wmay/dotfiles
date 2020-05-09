#!/bin/bash

# following the example at
# https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ln -sf ${BASEDIR}/gitconfig ~/.gitconfig
ln -sf ${BASEDIR}/gitignore_global ~/.gitignore_global
ln -sf ${BASEDIR}/emacs ~/.emacs
ln -sf ${BASEDIR}/config.fish ~/.config/fish/config.fish
ln -sf ${BASEDIR}/Rprofile ~/.Rprofile
ln -sf ${BASEDIR}/hidden ~/.hidden
