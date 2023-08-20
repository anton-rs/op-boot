#!/usr/bin/env bash

./node \
  --l1=${OP_NODE__RPC_ENDPOINT:="http://0.0.0.0:8545"} \
  --l2=${OP_NODE__ENGINE_ENDPOINT:="http://0.0.0.0:9551"} \
  --rollup.config=${OP_NODE__ROLLUP_CONFIG:="./rollup.json"} \
  --l2.jwt-secret=${OP_NODE__JWT_SECRET:="./jwt.hex"} \
  --rpc.addr=${OP_NODE__RPC_ADDR:="0.0.0.0"} \
  --rpc.port=${OP_NODE__RPC_PORT:=9000} \
  --l1.trustrpc
