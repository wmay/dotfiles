#!/bin/bash

code_pkgs=(
    curl
    fish
    powerline
)

sudo apt install ${code_pkgs[*]}

# set up fish
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
omf_pkgs=(
    bobthefish
    pisces
)
fish -c "omf install ${omf_pkgs[*]}"
# Note: the powerline characters may be broken in Ubuntu Sans Mono (the ubuntu
# default), but work with Ubuntu Mono. See
# https://github.com/powerline/powerline/issues/2264
# To fix, edit /etc/fonts/conf.avail/10-powerline-symbols.conf

chsh -s `which fish`

# following the example at
# https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/
BASEDIR="$(pwd)/dotfiles"
ln -sf ${BASEDIR}/.config/fish/config.fish ~/.config/fish/config.fish
