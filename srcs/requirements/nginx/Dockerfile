FROM debian:bullseye

RUN apt update && \
    apt install -y nginx && \
    rm -rf /var/lib/apt/lists/*

# Copy config (this folder *is* auto-loaded by nginx)
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

# Copy Docker secrets into place (Docker will handle these at runtime)
# Make sure permissions are correct for nginx
RUN mkdir -p /etc/ssl/certs /etc/ssl/private && chmod 600 /etc/ssl/private

CMD ["nginx", "-g", "daemon off;"]




#Official NGINX
# FROM debian:bullseye

# RUN apt update && \
#     apt install -y nginx openssl

# # RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
# #     -keyout /etc/ssl/private/nginx.key \
# #     -out /etc/ssl/certs/nginx.crt \
# #     -subj="/C=AU/ST=Vienna/L=Vienna/O=42Vienna/OU=mresch/CN=mresch.42.fr"

# # COPY ./tools/certs.sh /tmp/certs.sh
# # COPY nginx.crt /etc/ssl/certs/
# # COPY nginx.key /etc/ssl/private/

# #RUN chmod +x /tmp/certs.sh

# COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

# CMD ["nginx", "-g", "daemon off;"]
# #ENTRYPOINT ["/tmp/certs.sh"]
