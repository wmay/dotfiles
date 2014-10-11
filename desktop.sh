# Set up an Ubuntu, or Ubuntu derivative, desktop


# Install server things first, then do the rest in addition
sh server.sh
# This is my server setup script. Get it from [place]


# -- SSD things --
# ?


# -- get name of distribution --

# "name=`lsb_release -c -s`" doesn't get the Ubuntu name in Linux Mint!
# see http://forums.linuxmint.com/viewtopic.php?f=18&t=127743
# Better version:
name=`grep "VERSION=" /etc/os-release | awk '{print $(NF-1)}' | tr [:upper:] [:lower:]`


# -- REPOS --

repository_list=(

    # apt-fast
    ppa:saiarcot895/myppa

    # launchpad-getkeys, for fixing repo GPG keys
    ppa:nilarimogard/webupd8

    # Sun Java, for Gephi, etc.
    ppa:webupd8team/java

    # R CRAN
    "deb http://cran.rstudio.com/bin/linux/ubuntu $name/"

    # QGIS
    "deb http://qgis.org/debian $name main"

    # f.lux
    ppa:kilian/f.lux

    # pipelight (for Netflix on Firefox)
    ppa:pipelight/stable

    # SimpleScreenRecorder
    ppa:maarten-baert/simplescreenrecorder

    # Kapow punchclock and focuswriter
    # ppa:gottcode/gcppa

    # want to add a repo for emacs, but there's no good repo!
    # ppa:ubuntu-elisp/ppa
    
)


# adding the repositories
for repo in ${repository_list[*]}
do
    sudo add-apt-repository -y $repo
done




# -- fix repository GPG keys --

sudo apt-get update
# Unavoidable configuration dialog here. Meh.
sudo apt-get -y install launchpad-getkeys
sudo launchpad-getkeys

# this update fixes the missing key problems
sudo apt-get update


# get apt-fast
sudo apt-get install apt-fast


# -- programs --

program_list=(

    emacs

    # R statistical programming language
    r-base
    r-base-dev

    # Maxima computer algebra system (Maple alternative)
    maxima
    wxmaxima # nice interface

    # Octave, MATLAB alternative
    octave
    dynare # macroeconomic modeling add-on

    # QGIS
    qgis
    python-qgis

    oracle-java8-installer

    # for Netflix in Firefox
    pipelight-multi

    fluxgui

    skype

    simplescreenrecorder

    openshot

    gdmap

)


sudo apt-fast install ${program_list[*]}


# -- configure pipelight --
sudo pipelight-plugin --update
pipelight-plugin --enable silverlight
