all:
	docker-compose --file ./srcs/docker-compose.yaml --env-file ./srcs/.env up

re: clean
	docker-compose --file ./srcs/docker-compose.yaml --env-file ./srcs/.env up --build

stop:
	docker-compose --file ./srcs/docker-compose.yaml down

clean: stop
	docker volume prune -f
	docker system prune -af
