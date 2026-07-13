#!/bin/bash

code_pkgs=(
    curl
    default-jdk
    emacs emacs-common-non-dfsg # emacs info files
    # fonts-firacode
    # fonts-hack
    gcc gfortran
    git
    make
    pipx
    powerline
    valgrind
)
# android_pkgs=(
#     adb
#     heimdall-flash-frontend
# )
# deb_pkgs=(
#     apt-file
#     brz-debian
#     dh-make
#     pbuilder
#     ubuntu-dev-tools
# )

sudo apt install ${code_pkgs[*]}

pipx install tldr
tldr -u # get tldr entries

# set up ssh key
ssh-keygen -t ed25519 -C "wmay@hey.com"
ssh-add ~/.ssh/id_ed25519

# following the example at
# https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/
BASEDIR="$(pwd)/dotfiles"
ln -sf ${BASEDIR}/.gitconfig ~/.gitconfig
mkdir -p ~/.config/git
ln -sf ${BASEDIR}/.config/git/ignore ~/.config/git/ignore
