#!/bin/bash
# Set up an Ubuntu, or Ubuntu derivative, desktop
# run with `bash desktop.sh`
# don't use sudo!!


# Install server things first, then do the rest in addition
bash server.sh
# Or comment it out if you don't want a Ruby on Rails server


# -- SSD things --
# ?


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
# # elasticsearch key-- not what I'm looking for
# wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
# echo "deb http://packages.elastic.co/elasticsearch/2.x/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list
# may need
#sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1397BC53640DB551

# add postgresql repository
echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee -a /etc/apt/sources.list.d/pgdg.list
sudo apt-get install wget ca-certificates
wget --quiet --no-check-certificate -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update

# get other helpful repositories
repository_list=(
    # ppa:nilarimogard/webupd8
    # # launchpad-getkeys, for fixing repo GPG keys
    
    #ppa:saiarcot895/myppa
    # for apt-fast
       
    # Sun Java, for Java dev and Gephi
    #ppa:webupd8team/java

    # # R CRAN
    # "deb http://cran.rstudio.com/bin/linux/ubuntu $name/"

    # Dynare
    # no utopic repo at the moment
    #"deb http://www.dynare.org/ubuntu $name main contrib"

    # # Julia
    # ppa:staticfloat/julia-deps
    # ppa:staticfloat/juliareleases

    # Emergent - no utopic repo yet
    #"deb http://grey.colorado.edu/ubuntu trusty main"

    # QGIS
    #"deb http://qgis.org/debian $name main"

    # # Dropbox
    # "deb http://linux.dropbox.com/ubuntu $name main"

    # SimpleScreenRecorder
    #ppa:maarten-baert/simplescreenrecorder

    # # Kapow punchclock and focuswriter
    # ppa:gottcode/gcppa

    # # psensor
    # ppa:jfi/ppa

    # # Midori
    # ppa:midori/ppa
)

# adding the repositories
arraylength=${#array[@]}
for (( n=0; n<${#repository_list[@]}; n++ ));
do
  sudo add-apt-repository -y "${repository_list[$n]}"
done



# -- fix repository GPG keys --

# for Dropbox
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E

sudo apt-get update
# Unavoidable configuration dialog here. Meh.
# sudo apt-get -y install launchpad-getkeys
# sudo launchpad-getkeys

# # this update fixes the missing key problems
# sudo apt-get update


# get apt-fast
#sudo apt-get -y install apt-fast


# Programming
programming_pkgs=(
    make
    gcc
    gfortran
    emacs
    git
    curl
    valgrind

    # Debian packaging tools
    bzr-builddeb
    dh-make
)
sudo apt install ${programming_pkgs[*]}

# Stats
stats_pkgs=(
    r-base
    r-base-dev
    libxml2-dev # required for R devtools
    libssl-dev # same
    libcurl4-openssl-dev # also required for R packages
    wxmaxima
    # maxima-emacs # nice emacs interface
    # jags

    # python tools
    jupyter
    ipython3
)
sudo apt install ${stats_pkgs[*]}
# install some R packages
sudo Rscript packages.R

# Spatial analysis
# when will ubuntugis add bionic?:
# sudo add-apt-repository ppa:ubuntugis/ppa
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key CAEB3DC3BDF7FB45
sudo add-apt-repository 'deb https://qgis.org/debian bionic main'
geo_pkgs=(
    libgdal-dev
    libproj-dev
    libgeos-dev
    qgis

    # # GeoDa
    # freeglut3
    # libcurl4-gnutls-dev
    # libssl0.9.8
)
# # GeoDa
# # get .deb package
# curl https://geodacenter.org/downloads/unprotected/GeoDa-1.6.6-Ubuntu-64bit.deb -o geoda.deb
# # install
# sudo dpkg -i geoda.deb
# # delete unnecessary package file
# rm geoda.deb

# Utilities
util_pkgs=(
    synaptic
    # google-chrome-stable # get from online instead
    skype
    # simplescreenrecorder
    # openshot # easy video editing
    # gdmap # cool hard drive visualizer
    pinta # simple image editing program
    # default-jdk # for compiling Java
    evolution
    evolution-ews # connect to microsoft exchange servers

    # lubuntu-restricted-extras
    ubuntu-restricted-extras
    # unity-tweak-tool
    gnome-tweak-tool
    chrome-gnome-shell # for gnome extensions
)
sudo apt install ${util_pkgs[*]}

# program_list=(
#     # Octave (MATLAB alternative)
#     # octave
#     # dynare # macroeconomic modeling add-on

#     # # Julia
#     # julia

#     # emergent, cognitive science modelling
#     #emergent

#     # for Java dev and Gephi
#     #oracle-java8-installer

#     # need for taskwarrior conky!
#     # task
#     # conky
# )


# # this takes a while, even with apt-fast
# sudo apt-get -y install ${program_list[*]}

# # I had a problem with uninstalled dependencies, not sure why
# sudo apt-get -y install -f


# Research

# this repository contains zotero
sudo apt-add-repository ppa:smathot/cogscinl
research_pkgs=(
    texlive-latex-recommended
    texlive-publishers
    pandoc-citeproc
    zotero-standalone
)


# # some Ruby gems
# gem install mechanize


# Gephi

# # make a nice-looking desktop icon
# cp gephi.desktop ~/.local/share/applications/
# chmod +777 ~/.local/share/applications/gephi.desktop

# # add a hidden file to store misc. programs
# mkdir ~/.programs
# cd ~/.programs

# # download Gephi installer, put in programs folder
# # - using v. 0.9 because 0.8.2-beta is currently not working for me
# wget "https://github.com/gephi/gephi/releases/download/v0.9.0/gephi-0.9.0-linux.tar.gz"
# unzip gephi-0.9.0-linux.tar.gz # unzip
# rm gephi-0.9.0-linux.tar.gz
# # download the logo, put it in the gephi folder
# cd gephi
# wget http://gephi.github.io/images/badge/logo80.jpeg
