#!/bin/bash
set -e

echo "Waiting for database..."
until mysql -h "$WORDPRESS_DB_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SELECT 1" &> /dev/null; do
  echo "Database not ready..."
  sleep 5
done

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
        --dbhost="$WORDPRESS_DB_HOST"

    echo "Installing WordPress..."
    wp core install \
        --allow-root \
        --url="https://$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL"

    echo "Creating additional user..."
    wp user create "$WP_USER_NAME" "$WP_USER_EMAIL" \
        --allow-root \
        --user_pass="$WP_USER_PASSWORD"
fi

# Start PHP-FPM in foreground (Docker main process)
php-fpm7.4 -F

