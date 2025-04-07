# remove the greeting
set fish_greeting

# customize bobthefish theme
function fish_greeting; end
set -g theme_color_scheme base16-dark
set -g theme_date_timezone America/New_York

# package dev
set -g DEBFULLNAME "William May"
set -g DEBEMAIL "williamcmay@live.com"

# make the R remotes package less annoying
set -g R_REMOTES_UPGRADE "never"

# Ruby exports
set -gx GEM_HOME $HOME/gems
fish_add_path $HOME/gems/bin

# Fix tensorflow 2.16.1. See
# https://github.com/tensorflow/tensorflow/issues/63362#issuecomment-1988630226
set NVIDIA_PACKAGE_DIR /home/wmay/.local/lib/python3.10/site-packages/nvidia
for dir in $NVIDIA_PACKAGE_DIR/*/lib; set -gx LD_LIBRARY_PATH $dir $LD_LIBRARY_PATH; end
