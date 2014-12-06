#!/bin/bash
# Set up an Ubuntu server
# run with `bash server.sh`
# don't use sudo!!


# make sure package info is up to date
sudo apt-get update
sudo apt-get -y upgrade


# -- Install things --

program_list=( git

    curl
    libcurl4-openssl-dev

    # needed for unattended upgrades
    bsd-mailx

    unattended-upgrades

)

# install all programs
sudo apt-get -y install ${program_list[*]}


# -- RVM, Ruby, and Rails --
# do NOT run this with sudo!!

# get the gpg key first
gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --rails

# set RVM/Ruby/Rails environment variables for current shell
source ~/.rvm/scripts/rvm

# set future shell environment variables for RVM/Ruby/Rails
echo "source ~/.rvm/scripts/rvm" >> ~/.bashrc


# -- Passenger server --
gem install passenger


# -- Nginx server --
# More unavoidable configuration menus.  See
# https://www.digitalocean.com/community/tutorials/how-to-deploy-rails-apps-using-passenger-with-nginx-on-centos-6-5
# for context.
rvmsudo passenger-install-nginx-module

# move Nginx commands to the right folder, and make executable
# sudo cp nginx /etc/init.d/nginx
# sudo chmod +x /etc/init.d/nginx


# # -- configure Nginx --

# # replace original nginx.conf with pre-made file
# sudo cp nginx.conf /opt/nginx/conf/nginx.conf

# # restart Nginx with new configuration
# sudo /etc/init.d/nginx restart


# -- unattended upgrades --
# ?
