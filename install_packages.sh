#!/bin/bash
# Set up an Ubuntu, or Ubuntu derivative, desktop
# don't use sudo!!

# first add a few repository keys
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
repo_keys=(
    https://www.postgresql.org/media/keys/ACCC4CF8.asc
    https://github.com/retorquere/zotero-deb/releases/download/apt-get/deb.gpg.key
    https://download.spotify.com/debian/pubkey.gpg
)
for k in ${repo_keys[*]}; do
    wget -qO- $k | sudo apt-key add -
done

# and repositories
repos=(
    "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
    "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main"
    # ppa:ubuntugis/ppa
    ppa:timescale/timescaledb-ppa
    "deb https://github.com/retorquere/zotero-deb/releases/download/apt-get/ ./"
    "deb http://repository.spotify.com stable non-free"
)
for r in "${repos[@]}"; do
    sudo apt-add-repository -yu "$r"
done

# install packages
code_pkgs=(
    curl
    emacs
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
stats_pkgs=(
    ipython3
    jags
    julia
    jupyter
    r-base r-base-dev
    # wxmaxima maxima-emacs
    # libraries required for compiling R packages
    libxml2-dev
    libssl-dev
    libcurl4-openssl-dev
)
research_pkgs=(
    texlive-latex-recommended
    texlive-publishers
    pandoc-citeproc
    zotero
)
db_pkgs=(
    postgresql
    postgis
    timescaledb-postgresql-12
)
spatial_pkgs=(
    libgdal-dev
    libproj-dev
    libgeos-dev
    # qgis
)
util_pkgs=(
    chrome-gnome-shell # for gnome extensions
    evolution evolution-ews
    filezilla
    gnome-tweaks
    pinta # simple image editing program
    spotify-client
    ubuntu-restricted-extras
    vlc
)
android_pkgs=(
    adb
    heimdall-flash-frontend
)
deb_pkgs=(
    apt-file
    brz-debian
    dh-make
    pbuilder
    ubuntu-dev-tools
)
sudo apt install ${code_pkgs[*]} ${stats_pkgs[*]} \
     ${research_pkgs[*]} ${db_pkgs[*]} ${spatial_pkgs[*]} \
     ${util_pkgs[*]}


# Some setup afterward (probably need a makefile)

# Emacs packages
emacs --script install_packages.el

# switch to fish shell and set up fish
chsh -s `which fish`
curl -L https://get.oh-my.fish | fish
omf_pkgs=(
    bobthefish
    pisces
)
fish -c "omf install ${omf_pkgs[*]}"

# R packages
sudo Rscript packages.R
