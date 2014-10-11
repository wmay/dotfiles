# Set up an Ubuntu server
# run with 'sudo sh server.sh'


# make sure package info is up to date
sudo apt-get update


# -- Install things --
sudo apt-get -y install git curl libcurl4-openssl-dev unattended-upgrades bsd-mailx


# -- RVM, Ruby, and Rails --
# do NOT run this with sudo!!
\curl -sSL https://get.rvm.io | bash -s stable --rails

# set shell environment variables for RVM/Ruby/Rails
echo "source ~/.rvm/scripts/rvm" >> ~/.bashrc


# -- Passenger server --
gem install passenger


# -- Nginx server --
# More unavoidable configuration menus.  See
# https://www.digitalocean.com/community/tutorials/how-to-deploy-rails-apps-using-passenger-with-nginx-on-centos-6-5
# for context.
rvmsudo passenger-install-nginx-module

# move Nginx commands to the right folder, and make executable
sudo cp nginx /etc/init.d/nginx
sudo chmod +x /etc/init.d/nginx


# -- configure Nginx --

# ridiculous first attempt to edit nginx.conf:
# # add this to /opt/nginx/conf/nginx.conf
# text="    # Only for development purposes.\n
#     # For production environment, set it accordingly (i.e. production)\n
#     # Remove this line when you upload an actual application.\n
#     # For \* TESTING \* purposes only.\n
#     passenger_app_env development;"
# sed "/passenger_ruby/ a\
# `echo $text`" /opt/nginx/conf/nginx.conf | sudo tee /opt/nginx/conf/nginx.conf

# # add some more after the uncommented line,
# # "index index.html index.htm;"
# ng_num=`sed -n '/^[^#]*index  index\.html index\.htm;/=' /opt/nginx/conf/nginx.conf`+1
# ng_num=`echo $ng_num | bc`
# text2="    root /var/www/rails_app/public;\n
#     passenger_enabled on;"
# sed "$ng_num a\
# `echo $text2`" /opt/nginx/conf/nginx.conf | sudo tee /opt/nginx/conf/nginx.conf

# # comment out old app route
# this doesn't actually work
# sudo sed -e '/^[^#]*location \/ {/ s/^#*/#/' -i /opt/nginx/conf/nginx.conf
# sudo sed -e '/^[^#]*root   html;/ s/^#*/#/' -i /opt/nginx/conf/nginx.conf
# sudo sed -e '/^[^#]*index  index\.html index\.htm;/ s/^#*/#/' -i /opt/nginx/conf/nginx.conf
# sudo sed -e "$ng_num s/^#*/#/" -i /opt/nginx/conf/nginx.conf

# much better idea:
# replace original nginx.conf with pre-made file
sudo cp nginx.conf /opt/nginx/conf/nginx.conf

# restart Nginx with new configuration
/etc/init.d/nginx restart


# -- unattended upgrades --
# ?
