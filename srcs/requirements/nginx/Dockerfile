#Official NGINX
FROM debian:buster

RUN apt update; \
    apt install -y nginx openssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx.key \
    -out /etc/ssl/certs/nginx.crt \
    -subj="/C=AU/ST=Vienna/L=Vienna/O=42Vienna/OU=mresch/CN=mresch.42.fr"

#COPY ./tools/certs.sh /tmp/certs.sh

# COPY nginx.crt /etc/ssl/certs/
# COPY nginx.key /etc/ssl/private/

#RUN chmod +x /tmp/certs.sh

COPY ./conf/default /etc/nginx/sites-available/default 


CMD ["nginx", "-g", "daemon off;"]
#ENTRYPOINT ["/tmp/certs.sh"]
