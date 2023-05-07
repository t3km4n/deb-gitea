TOPDIR=$(PWD)

.PHONY: all build run scan clean multiarch slim slimup push pushghcr exec
all: run exec

scan:
	trivy image --severity HIGH,CRITICAL deb-gitea:latest > scanresults

run: build
	docker run -d \
	--name deb-gitea \
	-e ALLOW_EMPTY_PASSWORD=no \
	-e APP_DATA_PATH=/var/lib/gitea/data \
	-e RUN_MODE=prod \
	-p 2222:2222 \
	-p 3000:3000 \
	-v $(TOPDIR)/tmp:/var/lib/gitea/data \
	deb-gitea:latest

build:
	docker build -t deb-gitea:latest .

multiarch:
	docker buildx build --push --tag t3km4n/deb-gitea:latest --platform linux/amd64 .

slim:
	slim build --dockerfile Dockerfile --tag deb-gitea:slim .

slimup:
	docker run -d --name deb-gitea -p 3000:3000 deb-gitea:slim

push:
	docker tag deb-gitea:latest t3km4n/deb-gitea:latest
	docker push t3km4n/deb-gitea:latest

pushghcr:
	docker tag deb-gitea:latest ghcr.io/t3km4n/deb-gitea:latest
	docker push ghcr.io/t3km4n/deb-gitea:latest

exec:
	docker exec -it deb-gitea /bin/bash

clean:
	docker kill deb-gitea || true
	docker rm -f deb-gitea