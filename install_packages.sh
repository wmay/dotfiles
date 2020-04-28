#!/bin/bash
# Set up an Ubuntu, or Ubuntu derivative, desktop
# run with `bash desktop.sh`
# don't use sudo!!


# Programming
pkgs=(
    curl
    emacs
    fasd
    fish
    fonts-firacode
    fonts-hack
    gcc
    gfortran
    git
    make
    powerline
    valgrind
)
sudo apt install ${pkgs[*]}
# switch to fish shell and set up fish
chsh -s `which fish`
curl -L https://get.oh-my.fish | fish
omf_pkgs=(
    bobthefish
    fasd
    pisces
)
fish -c "omf install ${omf_pkgs[*]}; and fasd --init auto"
# get emacs config
mkdir ~/.emacs.d
git clone git@github.com:wmay/emacs_init.git ~/.emacs.d


# Statistics
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'
pkgs=(
    r-base
    r-base-dev
    libxml2-dev # required for R devtools
    libssl-dev # same
    libcurl4-openssl-dev # also required for R packages
    # wxmaxima
    # maxima-emacs # nice emacs interface
    # jags
    jupyter
    ipython3
)
sudo apt install ${pkgs[*]}
sudo Rscript packages.R


# Research
sudo apt-add-repository ppa:smathot/cogscinl # zotero
pkgs=(
    texlive-latex-recommended
    texlive-publishers
    pandoc-citeproc
    zotero-standalone
)
sudo apt install ${pkgs[*]}


# Postgres
# add postgresql repository
echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee -a /etc/apt/sources.list.d/pgdg.list
sudo apt-get install wget ca-certificates
wget --quiet --no-check-certificate -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo add-apt-repository ppa:timescale/timescaledb-ppa
sudo apt-get update
pkgs=(
    postgresql
    postgis
    timescaledb-postgresql-11
)
sudo apt install ${pkgs[*]}


# Spatial analysis
sudo add-apt-repository ppa:ubuntugis/ppa
pkgs=(
    libgdal-dev
    libproj-dev
    libgeos-dev
    qgis
)
sudo apt install ${pkgs[*]}


# Utilities
pkgs=(
    synaptic
    # google-chrome-stable # get from online instead
    skype
    # simplescreenrecorder
    # openshot # easy video editing
    pinta # simple image editing program
    # default-jdk # for compiling Java
    evolution
    evolution-ews # connect to microsoft exchange servers
    # lubuntu-restricted-extras
    ubuntu-restricted-extras
    gnome-tweak-tool
    chrome-gnome-shell # for gnome extensions
)
sudo apt install ${pkgs[*]}


# Android/LineageOS
pkgs=(
    adb
    heimdall-flash-frontend
)
sudo apt install ${pkgs[*]}


# Debian packaging
pkgs=(
    bzr-builddeb
    dh-make
)
sudo apt install ${pkgs[*]}
