include ./srcs/.env

DOCKER_COMPOSE_FILE := ./srcs/docker-compose.yml

.PHONY: all 
all: init
	docker-compose -f ${DOCKER_COMPOSE_FILE} up --build -d

.PHONY: init
init:
	mkdir -p ${WORDPRESS_VOLUME}
	mkdir -p ${MARIADB_VOLUME}

.PHONY: clean
clean: 
	docker-compose -f ${DOCKER_COMPOSE_FILE} down 

.PHONY: fclean
fclean:
	docker compose -f ${DOCKER_COMPOSE_FILE} down --rmi all
	sudo rm -rf ${WORDPRESS_VOLUME}
	sudo rm -rf ${MARIADB_VOLUME} 
