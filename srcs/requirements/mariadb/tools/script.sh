#!/bin/bash
set -e

service mysql start

until mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" ping --silent; do
  echo "Waiting for MariaDB ..." 
  sleep 1
done

mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"
#mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "ALTER USER '${MYSQL_ROOT_USER}'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"

sleep 4
echo "Testing connection before FLUSH PRIVILEGES"
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "SELECT 1;" && echo "SELECT 1 succeeded"

echo "Attempting FLUSH PRIVILEGES"
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;" && echo "FLUSH PRIVILEGES succeeded"

echo "5 Using root password: $MYSQL_ROOT_PASSWORD"

mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
echo "6 Using root password: $MYSQL_ROOT_PASSWORD"

exec mysqld_safe
echo "7 Using root password: $MYSQL_ROOT_PASSWORD"



