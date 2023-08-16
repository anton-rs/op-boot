#!/bin/sh
set -eou

while [ ! -f /shared/initialized.txt ]; do
  echo "Waiting for op-reth to initialize..."
  sleep 10
done

# Start op-node.
exec op-node \
  --l1=$OP_NODE__RPC_ENDPOINT \
  --l2=http://op-reth:8551 \
  --network=$NETWORK_NAME \
  --rpc.addr=127.0.0.1 \
  --rpc.port=9545 \
  --l2.jwt-secret=/shared/jwt.txt \
  --l1.trustrpc \
  --l1.rpckind=$OP_NODE__RPC_TYPE \
  --metrics.enabled \
  --metrics.addr=0.0.0.0 \
  --metrics.port=7300 \
  $@
