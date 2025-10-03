#!/bin/bash
set -e

if [ ! -f wp-config.php ]; then
  wp config create \
    --dbname="$WORDPRESS_DB_NAME" \
    --dbuser="$WORDPRESS_DB_USER" \
    --dbpass="$WORDPRESS_DB_PASSWORD" \
    --dbhost="$WORDPRESS_DB_HOST" \
    --allow-root
fi

until wp db check --allow-root > /dev/null 2>&1; do
  echo "⌛ MariaDB not ready yet..."
  sleep 2
done

if ! wp core is-installed --allow-root; then
  wp core install \
    --url="https://mresch.42.fr" \
    --title="Inception Blog" \
    --admin_user="admin" \
    --admin_password="adminpass" \
    --admin_email="admin@mresch.42.fr" \
    --allow-root
fi



php-fpm7.3 -F
exec php-fpm7.3 -F