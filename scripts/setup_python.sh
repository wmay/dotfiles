# set up python for data science work

stats_pkgs=(
    ipython3
    jupyter
    # libopenblas64-0-serial
    pipx
    python3-pip
    python3-venv
)

sudo apt install ${stats_pkgs[*]}

pipx install hatch # for python package dev

# following the example at
# https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ln -sf ${BASEDIR}/.ipython/profile_default/ipython_config.py ~/.ipython/profile_default/ipython_config.py
ln -sf ${BASEDIR}/.ipython/profile_default/startup/startup.ipy ~/.ipython/profile_default/startup/startup.ipy
ln -sf ${BASEDIR}/.condarc ~/.condarc
