# remove the greeting
set fish_greeting

# customize bobthefish theme
function fish_greeting; end
set -g theme_color_scheme base16-dark
set -g theme_date_timezone America/New_York
set -g theme_nerd_fonts yes

# package dev
set -g DEBFULLNAME "William May"
set -g DEBEMAIL "williamcmay@live.com"

# make the R remotes package less annoying
set -g R_REMOTES_UPGRADE "never"

# keep python venv from mucking up the prompt
set -g VIRTUAL_ENV_DISABLE_PROMPT 1

# Ruby exports
set -gx GEM_HOME $HOME/gems
fish_add_path $HOME/gems/bin

kubectl completion fish | source

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f $HOME/miniforge3/bin/conda
    eval $HOME/miniforge3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "$HOME/miniforge3/etc/fish/conf.d/conda.fish"
        . "$HOME/miniforge3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "$HOME/miniforge3/bin" $PATH
    end
end
# <<< conda initialize <<<
