FROM debian:bullseye

RUN apt update && \
    apt install -y nginx && \
    rm -rf /var/lib/apt/lists/*

# Copy config (this folder *is* auto-loaded by nginx)
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
