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
	@rm -rf jwt.txt
	@rm -rf jwt.hex
	@make clean-magi
	@make clean-op-node
	@make clean-op-reth
	@echo "[INFO] Done."

generate-jwt: ## generate a random jwt token and save it to jwt.hex
	@if [[ ! -f jwt.txt ]]; then echo "[INFO] Missing hex jwt, generating..." && openssl rand -hex 32 > jwt.txt; fi
.PHONY: generate-jwt

################################################################
# magi
################################################################

clean-magi: ## clean magi generated files
	@echo "[INFO] Cleaning magi generated files..."
	@rm -rf magi
	@rm -rf op-magi
	@echo "[INFO] Done."
.PHONY: clean-magi

# [INTERNAL TARGET]
magi-bin-non-exist:
	@if [[ -d "magi" ]]; then echo "[INFO] Updating magi..." && cd magi && git pull && cd ..; fi
	@if [[ ! -d "magi" ]]; then echo "[INFO] Cloning magi repository..." && git clone https://github.com/a16z/magi.git; fi
	@echo "[INFO] Building magi..."
	@cd magi && cargo build --release && cd ..
	@echo "[INFO] Copying the magi binary..."
	@cp -f ./magi/target/release/magi ./op-magi
	@echo "[INFO] Done."
.PHONY: magi-bin-non-exist

build-magi: ## build magi from source
	@if [[ -f op-magi ]]; then echo "[WARN] magi binary already installed." && exit 0; fi
	@if [[ ! -f op-magi ]]; then make magi-bin-non-exist; fi
.PHONY: build-magi

force-magi: ## force build magi from source, overwriting any existing binary
	@echo "[INFO] Forcing magi build..."
	@rm -f ./magi
	@make build-magi
	@echo "[INFO] Done."
.PHONY: force-magi

exec-magi: ## execute magi
	@make generate-jwt
	@if [[ ! -f magi ]]; then echo "[WARN] Missing magi executable, building from source..." && make build-magi; fi
	@echo "[INFO] Executing magi..."
	@./magi.sh
	@echo "[INFO] Done."
.PHONY: exec-magi

################################################################
# op-node
################################################################

clean-op-node: ## clean op-node generated files
	@echo "[INFO] Cleaning op-node generated files..."
	@rm -rf node
	@rm -rf optimism
	@rm -rf opnode_p2p_priv.txt
	@rm -rf opnode_peerstore_db
	@rm -rf opnode_discovery_db
	@echo "[INFO] Done."
.PHONY: clean-op-node

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

clean-op-reth: ## clean op-reth generated files
	@echo "[INFO] Cleaning op-reth generated files..."
	@rm -rf reth
	@rm -rf op_reth
	@rm -rf op-reth
	@echo "[INFO] Done."
.PHONY: clean-op-reth

# [INTERNAL TARGET]
op-reth-bin-non-exist:
	@if [[ -d "op-reth" ]]; then echo "[INFO] Updating op-reth..." && cd op-reth && git pull && cd ..; fi
	@if [[ ! -d "op-reth" ]]; then echo "[INFO] Cloning op-reth repository..." && git clone https://github.com/anton-rs/op-reth.git && cd op-reth && git checkout clabby/op-reth && cd ..; fi
	@echo "[INFO] Building op-reth..."
	@cd op-reth && cargo install --path bin/reth --bin reth --force --locked --features optimism --profile release && cd ..
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
	@make generate-jwt
	@if [[ ! -f reth ]]; then echo "[WARN] Missing op-reth executable, building from source..." && make build-op-reth; fi
	@echo "[INFO] Executing op-reth..."
	@./op-reth.sh
	@echo "[INFO] Done."
.PHONY: exec-op-reth

