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

clean:
	@echo "[INFO] Cleaning all generated files..."
	@make -C docker clean
	@make -C source clean
	@echo "[INFO] Done."
.PHONY: clean

################################################################
# source installs
################################################################

magi: ## executes magi from source
	@echo "[INFO] Building magi..."
	@make -C source exec-magi
	@echo "[INFO] Done."
.PHONY: magi

op-node: ## executes an op-node from source
	@echo "[INFO] Executing op-node..."
	@make -C source exec-op-node
	@echo "[INFO] Done."
.PHONY: op-node

op-reth: ## executes an op-reth from source
	@echo "[INFO] Executing op-reth..."
	@make -C source exec-op-reth
	@echo "[INFO] Done."
.PHONY: op-reth
