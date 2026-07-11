

# Zotero: https://github.com/retorquere/zotero-deb
wget -qO- https://raw.githubusercontent.com/retorquere/zotero-deb/master/zotero-archive-keyring.gpg |\
    sudo tee /usr/share/keyrings/zotero-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/zotero-archive-keyring.gpg by-hash=force] https://zotero.retorque.re/file/apt-package-archive ./" |\
    sudo tee /etc/apt/sources.list.d/zotero.list

sudo apt update -qq

research_pkgs=(
    texlive-latex-recommended texlive-publishers
    pandoc
    zotero
    libreoffice-java-common # for zotero connector
)

sudo apt install ${research_pkgs[*]}
