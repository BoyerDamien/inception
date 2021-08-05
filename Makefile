all: setup
	cd srcs && docker-compose up

setup:
	mkdir -p /home/dboyer/data/wordpressDB
	mkdir -p /home/dboyer/data/wordpressFiles

re: clean setup 
	cd srcs && docker-compose up --build

stop:
	cd srcs && docker-compose down

clean: stop
	docker volume prune -f
	docker system prune -af
	sudo rm -rf /home/dboyer/data
	
