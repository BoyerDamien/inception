all:
	docker-compose -f ./srcs/docker-compose.yaml --env-file ./srcs/.env up

re:
	docker-compose -f ./srcs/docker-compose.yaml --env-file ./srcs.env up --build

stop:
	docker-compose -f ./srcs/docker-compose.yaml down

clean:
	docker-compose -f ./srcs/docker-compose.yaml down
	docker volume prune -f
	docker system prune -af