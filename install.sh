#!/bin/sh

SITE=yurist.ru
WWW=/var/www

sudo mkdir -p ${WWW}/${SITE}/public_html
sudo chown -R $USER:$USER ${WWW}/${SITE}/public_html
sudo chmod -R 755 ${WWW}
sudo cp /etc/apache2/sites-available/default /etc/apache2/sites-available/${SITE}
#sudo vim /etc/apache2/sites-available/yurist.ru

sudo a2ensite ${SITE}
sudo service apache2 restart
#sudo vim /etc/hosts
