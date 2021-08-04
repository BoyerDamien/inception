all:
	cd srcs && docker-compose up

re: clean
	cd srcs && docker-compose up --build

stop:
	cd srcs && docker-compose down

clean: stop
	docker volume prune -f
	docker system prune -af
