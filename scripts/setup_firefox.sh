#!/bin/bash

# Firefox. The snap version of firefox that comes with ubuntu is ridiculously
# overzealous about security, not allowing firefox to open files in the /tmp
# folder (needed for viewing html plots). See
# https://bugs.launchpad.net/snapd/+bug/1972762.
# https://support.mozilla.org/en-US/kb/install-firefox-linux
sudo apt remove firefox && sudo snap remove firefox
sudo install -d -m 0755 /etc/apt/keyrings
wget -qO- https://packages.mozilla.org/apt/repo-signing-key.gpg |\
    sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" |\
    sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000

Package: firefox
Pin: release o=Ubuntu*
Pin-Priority: -1
' | sudo tee /etc/apt/preferences.d/mozilla

sudo apt update -qq

sudo apt install firefox
sudo apt install chrome-gnome-shell # for gnome extensions browser support

# following the example at
# https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FIREFOX_PROFILE_DIR=$(find ~/.config/mozilla/firefox -name '*.default-release' -type d | head -n 1)
mkdir -p ${FIREFOX_PROFILE_DIR}/chrome
ln -sf ${BASEDIR}/mozilla/firefox/profile.default/chrome/userContent.css ${FIREFOX_PROFILE_DIR}/chrome/userContent.css
