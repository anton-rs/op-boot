# Title: Makefile
# License: MIT
# Description: Targets to bootstrap a full optimism node from source.
# Author: refcell <https://github.com/refcell>

help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[$$()% a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

build: ## build both op-node and op-reth
	@echo "[INFO] Building op-node and op-reth..."
	@make build-op-node
	@make build-op-reth
	@echo "[INFO] Done."
.PHONY: build

clean: ## clean all generated files
	@echo "[INFO] Cleaning all generated files..."
	@rm -rf node
	@rm -rf reth
	@rm -rf jwt.hex
	@rm -rf op-reth
	@rm -rf optimism
	@rm -rf opnode_p2p_priv.txt
	@rm -rf opnode_peerstore_db
	@echo "[INFO] Done."

################################################################
# op-node
################################################################

generate-jwt: ## generate a random jwt token and save it to jwt.hex
	@if [[ ! -f jwt.hex ]]; then echo "[INFO] Missing hex jwt, generating..." && openssl rand -hex 32; fi
.PHONY: generate-jwt

# [INTERNAL TARGET]
op-node-bin-non-exist:
	@if [[ -d "optimism" ]]; then echo "[INFO] Updating optimism..." && cd optimism && git pull && cd ..; fi
	@if [[ ! -d "optimism" ]]; then echo "[INFO] Cloning optimism repository..." && git clone https://github.com/ethereum-optimism/optimism.git; fi
	@echo "[INFO] Building the op-node..."
	@make -C optimism op-node
	@echo "[INFO] Copying the op-node binary..."
	@cp -f ./optimism/op-node/bin/op-node ./node
	@echo "[INFO] Done."
.PHONY: op-node-bin-non-exist

build-op-node: ## build op-node from source
	@if [[ -f node ]]; then echo "[WARN] op-node binary already installed." && exit 0; fi
	@if [[ ! -f node ]]; then make op-node-bin-non-exist; fi
.PHONY: build-op-node

force-op-node: ## force build op-node from source, overwriting any existing binary
	@echo "[INFO] Forcing op-node build..."
	@rm -f ./node
	@make build-op-node
	@echo "[INFO] Done."
.PHONY: force-op-node

exec-op-node: ## execute op-node
	@make generate-jwt
	@if [[ ! -f node ]]; then echo "[WARN] Missing op-node executable, building from source..." && make build-op-node; fi
	@echo "[INFO] Executing op-node..."
	@./op-node.sh
	@echo "[INFO] Done."
.PHONY: exec-op-node

################################################################
# op-reth
################################################################

# [INTERNAL TARGET]
op-reth-bin-non-exist:
	@if [[ -d "op-reth" ]]; then echo "[INFO] Updating op-reth..." && cd op-reth && git pull && cd ..; fi
	@if [[ ! -d "op-reth" ]]; then echo "[INFO] Cloning op-reth repository..." && git clone https://github.com/anton-rs/op-reth.git && cd op-reth && git checkout clabby/op-reth && cd ..; fi
	@echo "[INFO] Building op-reth..."
	@FEATURES=optimism make -C op-reth install
	@echo "[INFO] Copying the reth binary..."
	@cp -f ./op-reth/target/release/reth ./reth
	@echo "[INFO] Done."
.PHONY: op-reth-bin-non-exist

force-op-reth: ## force build op-reth from source, overwriting any existing binary
	@echo "[INFO] Forcing op-reth build..."
	@rm -f ./reth
	@make build-op-reth
	@echo "[INFO] Done."
.PHONY: force-op-reth

build-op-reth: ## build op-reth from source
	@if [[ -f reth ]]; then echo "[WARN] Reth binary already installed." && exit 0; fi
	@if [[ ! -f reth ]]; then make op-reth-bin-non-exist; fi
.PHONY: build-op-reth

exec-op-reth: ## execute op-reth
	@if [[ ! -f reth ]]; then echo "[WARN] Missing op-reth executable, building from source..." && make build-op-reth; fi
	@echo "[INFO] Executing op-reth..."
	@./op-reth.sh
	@echo "[INFO] Done."
.PHONY: exec-op-reth

