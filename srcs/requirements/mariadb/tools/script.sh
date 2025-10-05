#!/bin/bash
set -e

# Start MariaDB in background (so we can run initialization commands)
mysqld_safe --skip-networking=0 --socket=/var/run/mysqld/mysqld.sock &

# Wait until MariaDB is ready
until mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" ping --silent; do
  echo "Waiting for MariaDB ..."
  sleep 1
done

# Run initialization SQL commands
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<-EOSQL
  CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
  CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
  GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
  FLUSH PRIVILEGES;
EOSQL

echo "MariaDB database and user initialized."

# Stop temporary mysqld instance
mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

# Finally, run MariaDB in the foreground (Docker main process)
exec mysqld_safe

