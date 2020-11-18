# remove the greeting
set fish_greeting

# customize bobthefish theme
function fish_greeting; end
set -g theme_color_scheme base16-dark

# package dev
set -g DEBFULLNAME "William May"
set -g DEBEMAIL "williamcmay@live.com"

# make the R remotes package less annoying
set -g R_REMOTES_UPGRADE "never"