prog:
	sudo apt update
	sudo apt-get update
	sudo snap install postman
	wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.0.2-amd64.deb
    sudo apt install ./slack-desktop-*.deb
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i --force-depends google-chrome-stable_current_amd64.deb
    sudo apt-get install nitroshare
    sudo apt update
    sudo apt install sublime-text
    sudo add-apt-repository ppa:nilarimogard/webupd8
    sudo apt update && sudo apt install gnome-twitch
    sudo apt remove gnome-twitch
    sudo add-apt-repository ppa:linuxuprising/shutter
    sudo apt-get update
    sudo apt install shutter
    sudo apt install gnome-web-photo
utils:
    sudo apt update
    sudo apt-get update
    sudo apt -y install curl dirmngr apt-transport-https lsb-release ca-certificates
    curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
    sudo apt -y install nodejs
    curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt-get update && sudo apt-get install yarn
    sudo apt install git
    sudo apt install nginx
    sudo service nginx start
    sudo service nginx restart
    sudo apt install redis-server
    sudo apt-get install software-properties-common python-software-properties
    sudo add-apt-repository -y ppa:ondrej/php
    sudo apt-get update
    sudo apt-get install php7.2 php7.2-cli php7.2-common
    sudo apt-get install php7.2-curl php7.2-gd php7.2-json php7.2-mbstring php7.2-intl php7.2-mysql php7.2-xml php7.2-zip php7.2-cli php7.2-fpm
    sudo service php7.2-fpm start
    sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password 1111'
    sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password 1111'
    sudo apt-get -y install mysql-server
    sudo apt-get install composer
    sudo apt install php-codesniffer
    sudo apt-get install php-xdebug
    sudo apt-get install supervisor
    sudo apt-get install php7.2-gm
www:
    sudo usermod -aG www-data vasily
    cd /var/www/ && sudo chown -R www-data:www-data .
    cd /var/www/ &&  sudo find . -type f -exec chmod 775 {} \;
    cd /var/www/ &&  sudo find . -type d -exec chmod 775 {} \;
    sudo ln -s /etc/nginx/sites-available/beautyboxl.ru /etc/nginx/sites-enabled/
    sudo usermod -a -G www-data vasily
    sudo apt update
    ssh-keygen
    sudo ssh-keygen
    sudo cat /root/.ssh/id_rsa.pub
    cat ~/.ssh/id_rsa.pub
    ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
    ssh -T git@github.com
    cd /var/www/ && sudo git clone git@github.com:SPITIRU/beautybox.git
    cd /var/www/ && git@github.com:SPITIRU/beautybox-crm.git
    openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout /etc/nginx/ssl/beautyboxl.key -out /etc/nginx/ssl/beautyboxl.crt
    openssl dhparam -out /etc/nginx/ssl/dhparam.pem 4096
    ssh-copy-id -i ~/.ssh/id_rsa vasily@domain.ru
    vi ~/.ssh/config
    ssh bb
    useradd -m -G ssh,sudo,adm,www-data vasily -s /bin/bash
    sudo passwd vasily
    sudo update-alternatives --set php /usr/bin/php7.2
docker:
    sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
    docker-compose --version
    sudo apt-get remove docker docker-engine docker.io containerd runc
    sudo apt-get update
    sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo apt-key fingerprint 0EBFCD88
    sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io
    apt-cache madison docker-ce
    sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io
    sudo docker run hello-world
    sudo docker ps
    sudo docker-compose exec cdek sh
    sudo docker-compose logs -f --tail=300 cdek
    sudo docker-compose restart







