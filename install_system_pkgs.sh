#!/bin/bash
# Set up an Ubuntu, or Ubuntu derivative, desktop
# don't use sudo!!

# Add the CRAN Ubuntu repository
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc |\
    sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"

# The snap version of firefox that comes with ubuntu is ridiculously overzealous
# about security, not allowing firefox to open files in the /tmp folder (needed
# for viewing html plots). See https://bugs.launchpad.net/snapd/+bug/1972762.
# The Ubuntu Mozilla team provides a .deb version
sudo snap remove firefox
sudo add-apt-repository ppa:mozillateam/ppa
# prioritize the .deb version
echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001

Package: firefox
Pin: version 1:1snap1-0ubuntu2
Pin-Priority: -1
' | sudo tee /etc/apt/preferences.d/mozilla-firefox
sudo apt install firefox

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
    graphviz
    intel-mkl
    ipython3
    jags
    # julia # no apt repo? get from https://julialang.org/
    jupyter
    libopenblas64-0-serial
    python3-pip
    python3-venv
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

# switch to fish shell and set up fish
chsh -s `which fish`
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
omf_pkgs=(
    bobthefish
    pisces
)
fish -c "omf install ${omf_pkgs[*]}"

# set up ssh key
ssh-keygen -t ed25519 -C "wmay@hey.com"
ssh-add ~/.ssh/id_ed25519

# R packages
sudo R CMD javareconf # for rJava
sudo Rscript packages.R

sudo update-alternatives --config libblas.so.3-x86_64-linux-gnu
sudo update-alternatives --config liblapack.so.3-x86_64-linux-gnu
