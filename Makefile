START=docker-compose -f ./srcs/docker-compose.yaml --env-file ./srcs/.env up
VOL_PATH=/home/dboyer/data

all: setup
	$(START)
setup:
	sudo mkdir -p $(VOL_PATH)/wordpressDB $(VOL_PATH)/wordpressFiles

re: clean setup 
	$(START) --build

stop:
	cd srcs && docker-compose down

clean: stop
	docker volume prune -f
	docker system prune -af
	sudo rm -rf $(VOL_PATH)
	
