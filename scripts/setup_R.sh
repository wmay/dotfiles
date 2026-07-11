#!/bin/bash

# set up R and R package development

# R/CRAN: https://cran.r-project.org/bin/linux/ubuntu/
sudo apt install --no-install-recommends software-properties-common dirmngr
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc |\
    sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc > /dev/null
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"

sudo apt update -qq

stats_pkgs=(
    default-jdk
    graphviz
    # intel-mkl
    libopenblas64-0-serial
    libudunits2-0
    r-recommended r-base-dev
    sqlite3
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

sudo apt install ${stats_pkgs[*]} ${rdev_pkgs[*]}

# switch to openblas
sudo update-alternatives --config libblas.so.3-x86_64-linux-gnu
sudo update-alternatives --config liblapack.so.3-x86_64-linux-gnu

# following the example at
# https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ln -sf ${BASEDIR}/.Rprofile ~/.Rprofile

# R packages
sudo R CMD javareconf # for rJava
sudo Rscript packages.R
