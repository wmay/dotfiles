# Miscellaneous nice things to have

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

sudo apt update -qq

util_pkgs=(
    # evolution evolution-ews
    gir1.2-gtop-2.0 gir1.2-nm-1.0 gir1.2-clutter-1.0 gnome-system-monitor # for system-monitor extension
    gnome-shell-extension-gsconnect-browsers
    gnome-shell-extension-manager
    # gnome-tweaks
    # libdvd-pkg
    lm-sensors # for Freon extension
    network-manager-openconnect-gnome # alternative to GlobalProtect
    # pinta # simple image editing program -- snap/flatpak only
    spotify-client
    ubuntu-restricted-extras
    # vlc
    zoom
)

sudo apt install ${util_pkgs[*]}

# following the example at
# https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ln -sf ${BASEDIR}/.hidden ~/.hidden
ln -sf ${BASEDIR}/Templates/beamer.Rmd ~/Templates/beamer.Rmd
ln -sf ${BASEDIR}/Templates/new.txt ~/Templates/new.txt
