#!/bin/bash

###########################################################################################################
# Origin: https://gist.github.com/Mins/4602864/raw/d2510fbf9a994f0cc984391061070d4df037ebee/mysql_secure.sh
# Migrate to RHEL/CentOS by pengyao
# Date: 2013-10-17 
###########################################################################################################

## Reqire MySQL ROOT Password 
MYSQL_ROOT_PASSWORD=""
MYSQL_ROOT_NEW_PASSWORD=""
if [ -z "$MYSQL_ROOT_NEW_PASSWORD" -a "x$1" == "x" ]
then
    echo "Missing MySQL ROOT New Password"
    exit 2
else
    MYSQL_ROOT_NEW_PASSWORD=$1
fi

## Install expect
rpm -q --quiet expect || yum -y -q install expect

SECURE_MYSQL=$(expect -c "

set timeout 10
spawn mysql_secure_installation

expect \"Enter current password for root (enter for none):\"
send \"$MYSQL_ROOT_PASSWORD\r\"

expect \"Change the root password?\"
send \"Y\r\"

expect \"New password:\"
send \"$MYSQL_ROOT_NEW_PASSWORD\r\"

expect \"Re-enter new password:\"
send \"$MYSQL_ROOT_NEW_PASSWORD\r\"

expect \"Remove anonymous users?\"
send \"y\r\"

expect \"Disallow root login remotely?\"
send \"y\r\"

expect \"Remove test database and access to it?\"
send \"y\r\"

expect \"Reload privilege tables now?\"
send \"y\r\"

expect eof
")

echo "$SECURE_MYSQL"

