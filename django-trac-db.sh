#!/bin/bash
PROJECT=$1
DBADMIN="${PROJECT}admin"
DBPASS=`openssl rand -base64 12`
DJANGODB="${PROJECT}_django"
TRACDB="${PROJECT}_trac"

if [[ $# -eq 0 ]] ; then
    echo 'usage: ./django-trac-db.sh PROJECT_NAME'
    exit 0
fi

echo "Enter root password"
read ROOTPASS
mysql -uroot -p${ROOTPASS} -e "CREATE DATABASE ${DJANGODB} CHARACTER SET utf8 COLLATE utf8_general_ci;"
mysql -uroot -p${ROOTPASS} -e "CREATE DATABASE ${TRACDB} CHARACTER SET utf8 COLLATE utf8_bin;"
mysql -uroot -p${ROOTPASS} -e "CREATE USER ${DBADMIN}@localhost IDENTIFIED BY '${USERPASS}';"
mysql -uroot -p${ROOTPASS} -e "GRANT ALL PRIVILEGES ON ${DJANGODB}.* TO '${DBADMIN}'@'localhost';"
mysql -uroot -p${ROOTPASS} -e "GRANT ALL PRIVILEGES ON ${TRACDB}.* TO '${DBADMIN}'@'localhost';" mysql -uroot -p${ROOTPASS} -e "FLUSH PRIVILEGES;"

echo Databases created
echo -----------------------------------------------------
echo User: ${DBADMIN}
echo Password: ${DBPASS}
echo Django DB: ${DJANGODB}
echo Trac DB: ${TRACDB}
