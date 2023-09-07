#!/bin/bash

# RPCs
OP_RETH="http://185.209.178.179:9545"
BASE_GOERLI="https://goerli.base.org"
BLOCK_NUMBER=4012992

# Array of receipt hashes
receipt_hashes=($(cast block $BLOCK_NUMBER --rpc-url $BASE_GOERLI --json | jq -r ".transactions[]"))

# Loop through each receipt hash and process
for RECEIPT_HASH in "${receipt_hashes[@]}"; do
        echo "Processing receipt hash: $RECEIPT_HASH"
        diff <(cast receipt $RECEIPT_HASH --rpc-url $OP_RETH --json | jq) <(cast receipt $RECEIPT_HASH --rpc-url $BASE_GOERLI --json | jq)
done
