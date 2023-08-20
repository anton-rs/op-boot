#!/usr/bin/env bash
set -eou

exec op-node \
  --l1=$OP_NODE__RPC_ENDPOINT \
  --l2=$OP_NODE__ENGINE_ENDPOINT \
  --network=$NETWORK_NAME \
  --rpc.addr=$OP_NODE__RPC_ADDR \
  --rpc.port=$OP_NODE__RPC_PORT \
  --l2.jwt-secret=$OP_NODE__JWT_SECRET \
  --metrics.enabled \
  --metrics.addr=$OP_NODE__METRICS_ADDR \
  --metrics.port=$OP_NODE__METRICS_PORT \
  --l1.rpckind=$OP_NODE__RPC_TYPE \
  --l1.trustrpc \
  $@
