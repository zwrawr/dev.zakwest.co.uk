#! /bin/bash

export ENVIRO="dev" # ENVIRO="dev"


echo -e "\n\n==== Begining Provisioning ====\n"

echo "User: $USER"
echo "Opernating system : $(cat /etc/issue)"
echo "Kernal version : $(uname -s) $(uname -r) , $(uname -o)"
echo "Network address (IP) :  $(hostname -i)"
echo "Enviroment : $ENVIRO"

echo -e "\n==== UPDATING SYSTEM ====\n"

# Tell apt that this is not an interactive session so it prompt or wait for input
# dpkg-preconfigure and debconf may be needed to seed valuesif defaults are not okay
export DEBIAN_FRONTEND=noninteractive

apt-get -y update
apt-get -y install nginx build-essential libssl-dev



echo -e "\n==== SETUP CONFIGS ====\n"

sudo rm -f /etc/nginx/sites-enabled/default
sudo rm -rf /var/www/html

sudo cp /var/www/www.zakwest.tech/config/www.zakwest.tech.service /etc/systemd/system/

if [ $ENVIRO = "dev" ]
    then
	sudo cp /var/www/www.zakwest.tech/config/www.dev.zakwest.tech.service /etc/systemd/system/
        sudo cp /var/www/www.zakwest.tech/config/www.dev.zakwest.tech /etc/nginx/sites-available/
        sudo ln -s /etc/nginx/sites-available/www.dev.zakwest.tech /etc/nginx/sites-enabled/
    else
	sudo cp /var/www/www.zakwest.tech/config/www.zakwest.tech.service /etc/systemd/system/
        sudo cp /var/www/www.zakwest.tech/config/www.zakwest.tech /etc/nginx/sites-available/
        sudo ln -s /etc/nginx/sites-available/www.zakwest.tech /etc/nginx/sites-enabled/
fi


echo -e "\n==== ADD USER ====\n"
sudo groupadd wwwzakwestcouk
sudo adduser --system --shell /bin/bash --force-badname --gecos 'Web application at www.zakwest.tech' --disabled-password wwwzakwestcouk
sudo usermod -a -G wwwzakwestcouk $USER


echo -e "\n==== DOWNLOAD & INSTALL NODE ====\n"

cd /tmp
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs
npm install -g npm@latest




cd /var/www/www.zakwest.tech

echo -e "\n==== INSTALL DEPS ====\n"

npm install uglify-js react@^16.0.0 acorn@^6.0.0 react-dom@^16.0.0
npm install

echo -e "\n==== BUILD SITE ====\n"
npm run build


echo -e "\n==== ENABLE SITE ====\n"

if [ $ENVIRO = "dev" ]
    then
	sudo systemctl enable www.dev.zakwest.tech.service
	sudo systemctl restart www.dev.zakwest.tech
    else
	sudo systemctl enable www.zakwest.tech.service
	sudo systemctl restart www.zakwest.tech
fi


sudo systemctl enable nginx.service
sudo systemctl restart nginx


echo -e "\n==== Check Status ====\n"
sleep 2
echo -e "\n NGINX"
sudo systemctl status nginx.service

echo -e "\b SITE"
if [ $ENVIRO = "dev" ]
    then
	sudo systemctl status www.dev.zakwest.tech.service
    else
	sudo systemctl status www.zakwest.tech.service
fi

echo -e "\n==== ! DONE ! ====\n"
