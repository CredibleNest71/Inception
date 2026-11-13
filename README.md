# Inception

A small WordPress infrastructure built with Docker Compose. Every service runs in its own container, built from my own Dockerfiles on `debian:bullseye` (no ready-made images).

```
          HTTPS :443
              │
         ┌────▼────┐       ┌─────────────────────┐       ┌─────────┐
browser ─►  NGINX  ├──────►│ WordPress + php-fpm ├──────►│ MariaDB │
         └─────────┘       └─────────────────────┘       └─────────┘
              TLS 1.2 / 1.3        port 9000                port 3306
```

## What it does

- **NGINX** is the only entry point, listening on port 443 with TLS 1.2 and 1.3 only
- **WordPress** runs on php-fpm and is installed on first start with WP-CLI (site, admin and a second user)
- **MariaDB** stores the WordPress data
- Containers start in order through health checks (`mariadb` → `wordpress` → `nginx`) and restart automatically
- Website files and database live on bind-mounted volumes, so data survives a rebuild
- The TLS certificate and key are passed in as Docker secrets
- All containers share one private bridge network, `inception`

## Setup

1. Copy the example config and fill in your own values:

   ```sh
   cp srcs/.env.example srcs/.env
   ```

2. Create a self-signed certificate at the paths set in `.env`:

   ```sh
   mkdir -p ~/mresch/data/certs
   openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
     -keyout ~/mresch/data/certs/nginx.key -out ~/mresch/data/certs/nginx.crt \
     -subj "/CN=mresch.42.fr"
   ```

3. Point the domain to localhost in `/etc/hosts`:

   ```
   127.0.0.1 mresch.42.fr
   ```

4. Build and start everything:

   ```sh
   make
   ```

Then open `https://mresch.42.fr` in the browser.

| Target | What it does |
| --- | --- |
| `make` | Create the volume folders, build the images and start the containers |
| `make clean` | Stop and remove the containers |
| `make fclean` | Also remove the images and the volume data |

## Structure

```
srcs/
├── docker-compose.yml
├── .env.example
└── requirements/
    ├── nginx/       Dockerfile, conf/default.conf
    ├── wordpress/   Dockerfile, tools/script.sh
    └── mariadb/     Dockerfile, tools/script.sh
```
