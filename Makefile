all:
	docker-compose -f ./srcs/docker-compose.yaml --env-file ./srcs/.env up

re: clean
	docker-compose -f ./srcs/docker-compose.yaml --env-file ./srcs/.env up --build

stop:
	docker-compose -f ./srcs/docker-compose.yaml down

clean: stop
	docker volume prune -f
	docker system prune -af