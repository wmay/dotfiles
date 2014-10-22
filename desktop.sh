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
name=`grep "VERSION=" /etc/os-release | awk '{print $(NF-1)}' | tr [:upper:] [:lower:]`


# -- REPOS --

repository_list=( ppa:saiarcot895/myppa
    # for apt-fast
    
    # launchpad-getkeys, for fixing repo GPG keys
    ppa:nilarimogard/webupd8

    # Sun Java, for Gephi etc.
    ppa:webupd8team/java

    # R CRAN
    "deb http://cran.rstudio.com/bin/linux/ubuntu $name/"

    # Dynare
    "deb http://www.dynare.org/ubuntu $name main contrib"

    # QGIS
    "deb http://qgis.org/debian $name main"

    # f.lux - not using anymore due to issues on Ubuntu
    # ppa:kilian/f.lux

    # pipelight (for Netflix on Firefox)
    ppa:pipelight/stable

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

    # Maxima computer algebra system (Maple alternative)
    maxima
    wxmaxima # nice interface

    # Octave (MATLAB alternative)
    octave
    dynare # macroeconomic modeling add-on

    # QGIS
    qgis
    python-qgis

    focuswriter

    # for Java dev and Gephi
    oracle-java8-installer

    # for Netflix in Firefox
    pipelight-multi

    # using redshift instead
    # fluxgui
    redshift-gtk

    # need for taskwarrior conky!
    task
    conky

    skype

    simplescreenrecorder

    openshot

    # cool hard drive visualizer
    gdmap

    # for GeoDa
    freeglut3
    libcurl4-gnutls-dev
    libssl0.9.8

    # flash and mp3 etc.
    ubuntu-restricted-extras

)


# this takes a while, even with apt-fast
sudo apt-fast -y install ${program_list[*]}

# I had a problem with uninstalled dependencies, not sure why
sudo apt-get -y install -f


# -- configure pipelight --
sudo pipelight-plugin --update
pipelight-plugin --enable silverlight


# GeoDa
# get .deb package
curl https://geodacenter.org/downloads/unprotected/GeoDa-1.6.6-Ubuntu-64bit.deb -o geoda.deb
# install
sudo dpkg -i geoda.deb
# delete unnecessary package file
rm geoda.deb


# Gephi

# add a hidden file to store misc. programs
mkdir ~/.programs
cd ~/.programs

# download Gephi installer, put in programs folder
# - using v. 0.9 because 0.8.2-beta is currently not working for me
curl -L "http://nexus.gephi.org/nexus/service/local/artifact/maven/content?r=snapshots&g=org.gephi&a=gephi&v=0.9-SNAPSHOT&p=zip" -o gephi-0.9-SNAPSHOT.zip
unzip gephi-0.9-SNAPSHOT.zip # unzip
rm gephi-0.9-SNAPSHOT.zip
alias gephi="/home/will/.programs/gephi/bin/gephi"
# download the logo, put it in the gephi folder
cd gephi
wget http://gephi.github.io/images/badge/logo80.jpeg
cd ..
cd ..
