#!/usr/bin/env bash

./op-magi \
  --network ${MAGI__NETWORK:="base-goerli"} \
  --jwt-secret ${MAGI__JWT_SECRET:="jwt.txt"} \
  --l1-rpc-url ${MAGI__L1_RPC_URL:="http://0.0.0.0:8545"} \
  --l2-rpc-url ${MAGI__L2_RPC_URL:="http://0.0.0.0:9545"} \
  --l2-engine-url ${MAGI__ENGINE_URL:="http://0.0.0.0:9551"} \
  --rpc-port ${MAGI__RPC_PORT:=7000} \
  --sync-mode ${MAGI__SYNC_MODE:="full"} \
  -v
