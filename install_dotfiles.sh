#!/bin/bash

# following the example at
# https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ln -s ${BASEDIR}/gitconfig ~/.gitconfig
ln -s ${BASEDIR}/gitignore_global ~/.gitignore_global
ln -s ${BASEDIR}/emacs ~/.emacs
ln -s ${BASEDIR}/hidden ~/.hidden
