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

# get other helpful repositories
repository_list=( ppa:saiarcot895/myppa
    # for apt-fast
    
    # launchpad-getkeys, for fixing repo GPG keys
    ppa:nilarimogard/webupd8

    # Sun Java, for Java dev and Gephi
    ppa:webupd8team/java

    # R CRAN
    "deb http://cran.rstudio.com/bin/linux/ubuntu $name/"

    # Dynare
    # no utopic repo at the moment
    # "deb http://www.dynare.org/ubuntu $name main contrib"

    # Emergent - no utopic repo yet
    "deb http://grey.colorado.edu/ubuntu trusty main"

    # QGIS
    "deb http://qgis.org/debian $name main"

    # SimpleScreenRecorder
    ppa:maarten-baert/simplescreenrecorder

    # Kapow punchclock and focuswriter
    ppa:gottcode/gcppa
    
)

# adding the repositories
arraylength=${#array[@]}
for (( n=0; n<${#repository_list[@]}; n++ ));
do
  sudo add-apt-repository -y "${repository_list[$n]}"
done



# -- fix repository GPG keys --

sudo apt-get update
# Unavoidable configuration dialog here. Meh.
sudo apt-get -y install launchpad-getkeys
sudo launchpad-getkeys

# this update fixes the missing key problems
sudo apt-get update


# get apt-fast
sudo apt-get -y install apt-fast


# -- programs --

program_list=( emacs

    # R statistical programming language
    r-base
    r-base-dev

    # Google Chrome. Because Netflix.
    google-chrome-stable

    # Maxima computer algebra system (Maple alternative)
    maxima
    # wxmaxima # nice interface
    maxima-emacs # nice emacs interface

    # Octave (MATLAB alternative)
    octave
    dynare # macroeconomic modeling add-on

    # emergent, cognitive science modelling
    emergent

    # QGIS
    qgis
    python-qgis

    # nice writing app
    focuswriter
    
    # punchclock
    kapow

    # for Java dev and Gephi
    oracle-java8-installer

    # good package manager
    synaptic

    # tint screen at night
    redshift-gtk

    # need for taskwarrior conky!
    task
    conky

    skype

    simplescreenrecorder

    openshot

    # cool hard drive visualizer
    gdmap

    # flash and mp3 etc.
    # lubuntu-restricted-extras
    unity-tweak-tool
    gnome-tweak-tool

    # for GeoDa
    freeglut3
    libcurl4-gnutls-dev
    libssl0.9.8
    
    # for R package, and probably other things
    libxml2-dev
)


# this takes a while, even with apt-fast
sudo apt-fast -y install ${program_list[*]}

# I had a problem with uninstalled dependencies, not sure why
sudo apt-get -y install -f


# install some R packages
sudo Rscript packages.R


# some Ruby gems
gem install mechanize


# GeoDa
# get .deb package
curl https://geodacenter.org/downloads/unprotected/GeoDa-1.6.6-Ubuntu-64bit.deb -o geoda.deb
# install
sudo dpkg -i geoda.deb
# delete unnecessary package file
rm geoda.deb


# Gephi

# make a nice-looking desktop icon
cp gephi.desktop ~/.local/share/applications/
chmod +777 ~/.local/share/applications/gephi.desktop

# add a hidden file to store misc. programs
mkdir ~/.programs
cd ~/.programs

# download Gephi installer, put in programs folder
# - using v. 0.9 because 0.8.2-beta is currently not working for me
curl -L "http://nexus.gephi.org/nexus/service/local/artifact/maven/content?r=snapshots&g=org.gephi&a=gephi&v=0.9-SNAPSHOT&p=zip" -o gephi-0.9-SNAPSHOT.zip
unzip gephi-0.9-SNAPSHOT.zip # unzip
rm gephi-0.9-SNAPSHOT.zip
# download the logo, put it in the gephi folder
cd gephi
wget http://gephi.github.io/images/badge/logo80.jpeg
