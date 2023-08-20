# Title: Makefile
# License: MIT
# Description: op-boot commands
# Author: refcell <https://github.com/refcell>

help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[$$()% a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

docker: ## boots the node using docker-compose
	@echo "[INFO] Booting the node with docker..."
	@make build-reth
	@echo "[INFO] Done."
.PHONY: docker

build-reth: ## builds reth inside the docker stack
	@make -C docker build-reth
.PHONY: build-reth

source: ## boots the node from source
	@echo "[INFO] Booting the node from source..."
	@./utils/parallel.sh \
	./utils/op-node-source.sh 'op-node' \
	./utils/op-reth-source.sh 'op-reth'
	@echo "[INFO] Done."
.PHONY: source


# op-node:
# 	# Pull the latest op-node docker image
# 	docker pull us-docker.pkg.dev/oplabs-tools-artifacts/images/op-node
#
