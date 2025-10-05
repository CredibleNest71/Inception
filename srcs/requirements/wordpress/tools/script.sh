#!/bin/bash
set -e

# Ensure target directory exists
mkdir -p /var/www/html
cd /var/www/html

# If WordPress is not already downloaded, fetch it
if [ ! -f wp-config.php ]; then
    echo "Downloading WordPress core..."
    wp core download --allow-root

    echo "Creating wp-config.php..."
    wp config create \
        --allow-root \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --dbhost="mariadb:3306"

    echo "Installing WordPress..."
    wp core install \
        --allow-root \
        --url="https://$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL"

    echo "Creating additional user..."
    wp user create "$WP_USER" "$WP_USER_EMAIL" \
        --allow-root \
        --user_pass="$WP_USER_PASSWORD"
fi

# Start PHP-FPM in foreground (Docker main process)
php-fpm7.4 -F

