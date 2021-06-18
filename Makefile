.PHONY: all
all: ps ;

.PHONY: up
up: ./conf/nginx/conf.d ./conf/nginx/sites.d ./conf/nginx/auth
	docker-compose up -d

.PHONY: down
down:
	docker-compose down

.PHONY: reload
reload:
	$(MAKE) down
	$(MAKE) up

.PHONY: restart
restart:
	docker-compose restart

.PHONY: build
build:
	docker-compose build

.PHONY: pull
pull:
	docker-compose pull

.PHONY: log
log:
	docker-compose logs -f --tail 0

.PHONY: ps
ps:
	docker-compose ps

.PHONY: top
top:
	docker-compose top

# -----------------------------------------------------------------------------

.PHONY: backup
backup:
	sudo bash _helpers/backup.sh var

# -----------------------------------------------------------------------------
# https://makefiletutorial.com/#automatic-variables
./conf/nginx/conf.d ./conf/nginx/sites.d ./conf/nginx/auth:
	mkdir -p "$@"
