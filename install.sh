#!/bin/sh

#
# -- check arguments
#
if [ $# -eq 0 ]
then 
	echo "No arguments supplied"
	exit
fi

#
# -- init variables
#
IP_ADDRESS=`/sbin/ifconfig eth1 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'`
DOCUMENT_ROOT=/var/www
SITE_NAME=$1
SITE_HOME=${DOCUMENT_ROOT}/${SITE_NAME}/public_html

#
# -- create a home directory for future site
#
sudo mkdir -p ${SITE_HOME}
sudo chown -R $USER:$USER ${SITE_HOME}
sudo chmod -R 755 ${DOCUMENT_ROOT}
cd
ln -s ${SITE_HOME} ${SITE_NAME}

#
# -- enable site
#
sudo cp /etc/apache2/sites-available/default /etc/apache2/sites-available/${SITE_NAME}
sudo sed -i "s#DocumentRoot ${DOCUMENT_ROOT}#DocumentRoot ${SITE_HOME}#" /etc/apache2/sites-available/${SITE_NAME}
sudo a2ensite ${SITE_NAME}
sudo service apache2 restart

#
# -- add virtual address to hosts
#
sudo echo ${IP_ADDRESS}" \t "${SITE_NAME} >> /etc/hosts

#
# -- create test index.php page
#
TEST_PAGE=${SITE_HOME}/index.php
cat >${TEST_PAGE} <<EOL
<html>
  <head>
    <title>Welcome to ${SITE_NAME}!</title>
  </head>
  <body>
    <h1>Success! The ${SITE_NAME} virtual host is working!</h1>
    <?phpinfo();?>
  </body>
</html>
EOL

#
# -- test
#
wget 127.0.0.1/${SITE_NAME}/public_html/index.php

