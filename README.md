Data science dotfiles and installation scripts for Ubuntu 26.04, Emacs, and
fish. Mostly focused on R and related tools for now.

## Installation

In theory you can run these from the command line (but it's probably wiser to
just run them piecemeal instead).

```sh
./scripts/install_system_pkgs.sh
./.emacs # install emacs packages
./scripts/install_R_pkgs.R
./scripts/install_dotfiles.sh # add symlinks to home folder
```
