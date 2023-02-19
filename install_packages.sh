#!/bin/bash
# Set up an Ubuntu, or Ubuntu derivative, desktop
# don't use sudo!!

# install packages
code_pkgs=(
    curl
    default-jdk
    emacs
    emacs-common-non-dfsg # emacs info files
    fish
    # fonts-firacode
    # fonts-hack
    gcc
    gfortran
    git
    make
    powerline
    tldr
    valgrind
)
stats_pkgs=(
    ipython3
    jags
    # julia # no apt repo? get from https://julialang.org/
    jupyter
    libopenblas64-0-serial
    python3-pip
    r-recommended r-base-dev
    sqlite3
    # wxmaxima maxima-emacs
)
# libraries required for compiling/creating R packages
rdev_pkgs=(
    libcurl4-openssl-dev
    libfontconfig1-dev libharfbuzz-dev libfribidi-dev # for pkgdown
    libgit2-dev # for usethis
    libssl-dev
    libxml2-dev
    qpdf # for R CMD check
    texlive-fonts-extra # for inconsolata.sty
)
research_pkgs=(
    texlive-latex-recommended
    texlive-publishers
    pandoc pandoc-citeproc
    # zotero # get it from https://github.com/retorquere/zotero-deb
)
# spatial_pkgs=(
#     libgdal-dev
#     libproj-dev
#     libgeos-dev
#     # qgis
# )
util_pkgs=(
    # evolution evolution-ews
    gir1.2-gtop-2.0 gir1.2-nm-1.0 gir1.2-clutter-1.0 gnome-system-monitor # for system-monitor extension
    gnome-shell-extension-gsconnect-browsers
    gnome-shell-extension-manager
    # gnome-tweaks
    libdvd-pkg
    lm-sensors # for Freon extension
    network-manager-openconnect-gnome # alternative to GlobalProtect
    pinta # simple image editing program
    # spotify-client # get it from https://www.spotify.com/us/download/linux/
    ubuntu-restricted-extras
    vlc
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
sudo apt install ${code_pkgs[*]} ${stats_pkgs[*]} ${rdev_pkgs[*]} \
     ${research_pkgs[*]} ${util_pkgs[*]}


# Some setup afterward (probably need a makefile)

tldr -u # get tldr entries

# Emacs packages
emacs --script install_packages.el

# switch to fish shell and set up fish
chsh -s `which fish`
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
omf_pkgs=(
    bobthefish
    pisces
)
fish -c "omf install ${omf_pkgs[*]}"

# R packages
sudo R CMD javareconf # for rJava
sudo Rscript packages.R
