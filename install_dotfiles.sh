#!/bin/bash

# following the example at
# https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ln -sf ${BASEDIR}/.gitconfig ~/.gitconfig
mkdir -p .config/git
ln -sf ${BASEDIR}/.config/git/ignore ~/.config/git/ignore
ln -sf ${BASEDIR}/.emacs ~/.emacs
ln -sf ${BASEDIR}/config.fish ~/.config/fish/config.fish
ln -sf ${BASEDIR}/.Rprofile ~/.Rprofile
ln -sf ${BASEDIR}/.hidden ~/.hidden
ln -sf ${BASEDIR}/.ipython/profile_default/ipython_config.py ~/.ipython/profile_default/ipython_config.py
ln -sf ${BASEDIR}/.ipython/profile_default/startup/startup.ipy ~/.ipython/profile_default/startup/startup.ipy
