#!/usr/bin/env bash

# Add repositories + `apt-get update`
add-apt-repository ppa:ondrej/php # PHP
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - # Yarn
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list # Yarn
curl -sL https://deb.nodesource.com/setup_12.x | bash - # Node
apt-get update

# Install Docker

apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Initialize a Docker Swarm (some Docker Compose setups need it)
docker swarm init

# Install fish 
apt-get install -y fish
chsh -s /usr/bin/fish veselin

# Install PHP + extensions
apt-get install -y php7.3
apt-get install -y php7.3-bcmath php7.3-bz2 php7.3-cgi php7.3-cli php7.3-curl php7.3-dba php7.3-enchant php7.3-fpm php7.3-gd php7.3-gmp php7.3-imap php7.3-interbase php7.3-intl php7.3-json php7.3-ldap php7.3-mbstring php7.3-mysql php7.3-odbc php7.3-opcache php7.3-pgsql php7.3-pspell php7.3-readline php7.3-recode php7.3-snmp php7.3-soap php7.3-sqlite3 php7.3-sybase php7.3-tidy php7.3-xml php7.3-xmlrpc php7.3-xsl php7.3-zip 

# Install Composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /bin/composer

# Install Node and Yarn
apt-get install -y nodejs
apt-get install -y yarn

# Install Symfony CLI
wget https://get.symfony.com/cli/installer -O - | bash
mv $HOME/.symfony/bin/symfony /usr/local/bin/symfony

# Install misc. packages
apt-get install -y unzip

# https://docs.docker.com/install/linux/linux-postinstall/
usermod -aG docker veselin

# Disable the Ubuntu MOTD
touch /home/veselin/.hushlogin

# Disable the default fish greeting
mkdir -p /home/veselin/.config/fish/
echo "set fish_greeting" >> /home/veselin/.config/fish/config.fish
chown -R veselin:veselin /home/veselin/.config/

# Git config
su -c "git config --global credential.helper store" veselin
su -c "git config --global user.name \"Veselin Romić\"" veselin
su -c "git config --global user.email \"veselin.romic@infostud.com\"" veselin

# Increase the inotify watcher limit 
echo fs.inotify.max_user_watches=524288 | tee -a /etc/sysctl.conf && sysctl -p