all: build-reth

build-reth:
	@if [ ! -d "op-reth" ]; then @echo "Cloning op-reth repository..." && @git clone https://github.com/anton-rs/op-reth.git; fi
	@echo "Building op-reth..."
	@make -C op-reth install
	@echo "Copying the reth binary..."
	@cp -f ./op-reth/target/release/reth ./reth
	@echo "Done."
.PHONY: build-reth

docker-compose:
	@echo "Starting docker-compose..."
	@docker-compose up -d
	@echo "Done."
.PHONY: docker-compose

