#!/bin/bash
# Set up an Ubuntu, or Ubuntu derivative, desktop
# run with `bash desktop.sh`
# don't use sudo!!


# -- SSD things --
# see https://easylinuxtipsproject.blogspot.com/p/ssd.html


# -- get name of distribution --

# "name=`lsb_release -c -s`" doesn't get the Ubuntu name in Linux Mint!
# see http://forums.linuxmint.com/viewtopic.php?f=18&t=127743
# Better version:
name=`grep "VERSION=" /etc/os-release | awk '{print $(NF-1)}' | tr [:upper:] [:lower:] | tr -d '('`


# -- REPOS --

# enable the Canonical partners repository
sudo sed -i "/^# deb .*partner/ s/^# //" /etc/apt/sources.list

# add Google Chrome repository
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
# may need
#sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1397BC53640DB551



# # get other helpful repositories
# repository_list=(
#     # # Julia
#     # ppa:staticfloat/julia-deps
#     # ppa:staticfloat/juliareleases

#     # Emergent - no utopic repo yet
#     #"deb http://grey.colorado.edu/ubuntu trusty main"

#     # # Dropbox
#     # "deb http://linux.dropbox.com/ubuntu $name main"

#     # SimpleScreenRecorder
#     #ppa:maarten-baert/simplescreenrecorder

#     # # Kapow punchclock and focuswriter
#     # ppa:gottcode/gcppa
# )

# # adding the repositories
# arraylength=${#array[@]}
# for (( n=0; n<${#repository_list[@]}; n++ ));
# do
#   sudo add-apt-repository -y "${repository_list[$n]}"
# done



# -- fix repository GPG keys --

# for Dropbox
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
sudo apt-get update


# Programming
pkgs=(
    make
    gcc
    gfortran
    emacs
    git
    curl
    valgrind
    fish
    powerline
    fonts-firacode
    fonts-hack
    fonts-inconsolata
)
sudo apt install ${pkgs[*]}


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


# Misc
# program_list=(
#     # Octave (MATLAB alternative)
#     # octave
#     # dynare # macroeconomic modeling add-on

#     # # Julia
#     # julia

#     # emergent, cognitive science modelling
#     #emergent
# )
# sudo apt-get install ${program_list[*]}



