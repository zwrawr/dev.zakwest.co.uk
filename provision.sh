#! /bin/bash

export ENVIRO="dev" # ENVIRO="dev"


echo -e "\n\n==== Begining Provisioning ====\n"

echo "User : $USER"
echo "Operating system : $(uname -s) $(uname -r) , $(uname -o)"
echo "Network address (IP) :  $(hostname -i)"


echo -e "\n==== UPDATING SYSTEM ====\n"

apt-get update
apt-get install nginx build-essential libssl-dev -y



echo -e "\n==== SETUP CONFIGS ====\n"

sudo rm -f /etc/nginx/sites-enabled/default
sudo rm -rf /var/www/html

sudo cp /var/www/www.zakwest.tech/config/www.zakwest.tech.service /etc/systemd/system/

if [ $ENVIRO = "dev" ]
    then
        sudo cp /var/www/www.zakwest.tech/config/www.dev.zakwest.tech /etc/nginx/sites-available/
        sudo ln -s /etc/nginx/sites-available/www.dev.zakwest.tech /etc/nginx/sites-enabled/
    else
        sudo cp /var/www/www.zakwest.tech/config/www.zakwest.tech /etc/nginx/sites-available/
        sudo ln -s /etc/nginx/sites-available/www.zakwest.tech /etc/nginx/sites-enabled/
fi


echo -e "\n==== ADD USER ====\n"
sudo groupadd zakwest.tech
sudo adduser --system --shell /bin/bash --force-badname --gecos 'Web application at www.zakwest.tech' --disabled-password zakwest.tech
sudo usermod -a -G zakwest.tech $USER


echo -e "\n==== DOWNLOAD & INSTALL NODE ====\n"

cd /tmp
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs



echo -e "\n==== BUILD SITE ====\n"

cd /var/www/www.zakwest.tech

npm update

npm install -g uglify-js
npm install

npm build
npm run build


echo -e "\n==== ENABLE SITE ====\n"

sudo systemctl enable www.zakwest.tech.service
sudo systemctl restart www.zakwest.tech

sudo systemctl enable nginx.service
sudo systemctl restart nginx


echo -e "\n==== Check Status ====\n"
sleep 2
echo -e "\n NGINX"
sudo systemctl status nginx.service

echo -e "\b SITE"
sudo systemctl status www.zakwest.tech.service

echo -e "\n==== ! DONE ! ====\n"
