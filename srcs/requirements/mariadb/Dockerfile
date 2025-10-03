FROM debian:buster

RUN apt-get update -y
RUN apt-get install -y mariadb-server



COPY ./tools/script.sh /tmp/script.sh

RUN chmod +x /tmp/script.sh

RUN sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf 

EXPOSE 3306

ENTRYPOINT ["bash", "/tmp/script.sh"]



