FROM ubuntu:22.04

WORKDIR /op-reth

# Disable prompts during package installation.
ARG DEBIAN_FRONTEND=noninteractive

# Install required packages.
RUN apt-get update && apt install -y curl wget git rsync build-essential openssl python3 python3-pip

# Install Go.
RUN curl -sSL https://golang.org/dl/go1.19.5.linux-amd64.tar.gz | tar -v -C /usr/local -xz
RUN cp /usr/local/go/bin/go /usr/bin/go

# Install Foundry.
RUN curl -L https://foundry.paradigm.xyz | bash
RUN /root/.foundry/bin/foundryup
RUN rsync -a /root/.foundry/bin/ /usr/bin/

# Install Python packages.
RUN pip3 install qbittorrent-api

# Install Rust.
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
RUN rustup toolchain install nightly
RUN rustup default nightly

COPY Cargo.toml Cargo.lock ./
RUN mkdir -p src/bin && echo "fn main() {}" > src/bin/dummy.rs
RUN RUSTFLAGS="$(cat /.rustflags)" cargo build --release --config net.git-fetch-with-cli=true --bin dummy

COPY ./op-reth/ ./
RUN RUSTFLAGS="$(cat /.rustflags)" cargo build --release --config net.git-fetch-with-cli=true
RUN cp /reth/target/nightly/release/reth /reth/reth

FROM debian:bullseye-slim
RUN apt-get update && apt-get install -y libssl-dev ca-certificates && rm -rf /var/lib/apt/lists/*
COPY --from=build /reth/reth /usr/local/bin
