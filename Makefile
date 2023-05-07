all: build run 

run: build
	docker run -d \
	--name deb-gitea \
	-e GITEA_ADMIN_USER=admin \
	-e GITEA_ADMIN_PASSWORD=admin \
	-e GITEA_ADMIN_EMAIL=admin@localhost \
	-e ALLOW_EMPTY_PASSWORD=no \
	-e APP_DATA_PATH=/var/lib/gitea/data \
	-e RUN_MODE=prod \
	-p 2222:2222 \
	-p 3000:3000 \
	deb-gitea:latest

build:
	docker build -t deb-gitea:latest .

slim:
	slim build --dockerfile Dockerfile --tag deb-gitea:slim .

slimup:
	docker run -d --name deb-geoip -p 3000:3000 deb-geoip:slim

exec:
	docker exec -it deb-gitea /bin/bash

clean:
	docker kill deb-gitea || true
	docker rm -f deb-gitea