all:
	docker compose -f srcs/docker-compose.yml up --build -d

down: 
	docker compose -f srcs/docker-compose.yml down 
	
clean: down
	docker systemprune -af --volumes
