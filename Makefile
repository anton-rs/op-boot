all: op-node

# Docker boots the op-stack using docker-compose
docker: build-reth
.PHONY: docker

# Builds reth inside the docker stack
build-reth:
	make -C docker build-reth
.PHONY: build-reth



op-node:
	# Pull the latest op-node docker image
	docker pull us-docker.pkg.dev/oplabs-tools-artifacts/images/op-node

