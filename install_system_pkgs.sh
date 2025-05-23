#!/bin/bash
# Set up an Ubuntu, or Ubuntu derivative, desktop
# don't use sudo!!

# Adding repositories

sudo apt update -qq
sudo install -d -m 0755 /etc/apt/keyrings

# Firefox. The snap version of firefox that comes with ubuntu is ridiculously
# overzealous about security, not allowing firefox to open files in the /tmp
# folder (needed for viewing html plots). See
# https://bugs.launchpad.net/snapd/+bug/1972762.
# https://support.mozilla.org/en-US/kb/install-firefox-linux
sudo apt remove firefox && sudo snap remove firefox
wget -qO- https://packages.mozilla.org/apt/repo-signing-key.gpg |\
    sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" |\
    sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000

Package: firefox
Pin: version 1:1snap1-0ubuntu5
Pin-Priority: -1
' | sudo tee /etc/apt/preferences.d/mozilla
# R/CRAN: https://cran.r-project.org/bin/linux/ubuntu/
sudo apt install --no-install-recommends software-properties-common dirmngr
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc |\
    sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc > /dev/null
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
# Spotify: https://www.spotify.com/us/download/linux/
curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg |\
    sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb https://repository.spotify.com stable non-free" |\
    sudo tee /etc/apt/sources.list.d/spotify.list
# Zoom: https://github.com/mwt/zoom-apt-repo
wget -qO- https://mirror.mwt.me/zoom/gpgkey |\
    sudo tee /etc/apt/keyrings/mwt.asc > /dev/null
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/mwt.asc by-hash=force] https://mirror.mwt.me/zoom/deb any main" |\
    sudo tee /etc/apt/sources.list.d/mwt.list
# Zotero: https://github.com/retorquere/zotero-deb
wget -qO- https://raw.githubusercontent.com/retorquere/zotero-deb/master/zotero-archive-keyring.gpg |\
    sudo tee /usr/share/keyrings/zotero-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/zotero-archive-keyring.gpg by-hash=force] https://zotero.retorque.re/file/apt-package-archive ./" |\
    sudo tee /etc/apt/sources.list.d/zotero.list
# Docker
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# Kubernetes
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key |\
    sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' |\
    sudo tee /etc/apt/sources.list.d/kubernetes.list

# install packages
code_pkgs=(
    curl
    default-jdk
    docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    emacs emacs-common-non-dfsg # emacs info files
    fish
    # fonts-firacode
    # fonts-hack
    gcc gfortran
    git
    kubectl
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
    libudunits2-0
    python3-pip python3-venv
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
    texlive-latex-recommended texlive-publishers
    pandoc
    zotero
    libreoffice-java-common # for zotero connector
)
spatial_pkgs=(
    libgdal-dev
    libproj-dev
    libgeos-dev
    # qgis
)
util_pkgs=(
    chrome-gnome-shell # for gnome extensions browser support
    firefox
    # evolution evolution-ews
    gir1.2-gtop-2.0 gir1.2-nm-1.0 gir1.2-clutter-1.0 gnome-system-monitor # for system-monitor extension
    gnome-shell-extension-gsconnect-browsers
    gnome-shell-extension-manager
    # gnome-tweaks
    libdvd-pkg
    lm-sensors # for Freon extension
    network-manager-openconnect-gnome # alternative to GlobalProtect
    # pinta # simple image editing program -- snap/flatpak only
    spotify-client
    ubuntu-restricted-extras
    vlc
    zoom
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
# Note: the powerline characters may be broken in Ubuntu Sans Mono (the ubuntu
# default), but work with Ubuntu Mono. See
# https://github.com/powerline/powerline/issues/2264

# set up ssh key
ssh-keygen -t ed25519 -C "wmay@hey.com"
ssh-add ~/.ssh/id_ed25519

# R packages
sudo R CMD javareconf # for rJava
sudo Rscript packages.R

sudo update-alternatives --config libblas.so.3-x86_64-linux-gnu
sudo update-alternatives --config liblapack.so.3-x86_64-linux-gnu
