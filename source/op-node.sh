#!/usr/bin/env bash
set -eou

# OP_GETH_GENESIS_FILE_PATH=goerli/genesis-l2.json
OP_GETH_SEQUENCER_HTTP=https://goerli-sequencer.base.org

# auth secret used by op-reth engine API:
export OP_NODE_L2_ENGINE_RPC=http://0.0.0.0:9551
export OP_NODE_LOG_LEVEL=info
export OP_NODE_METRICS_ADDR=0.0.0.0
export OP_NODE_METRICS_ENABLED=true
export OP_NODE_METRICS_PORT=7300
export OP_NODE_P2P_AGENT=base
export OP_NODE_P2P_BOOTNODES=enr:-J64QBbwPjPLZ6IOOToOLsSjtFUjjzN66qmBZdUexpO32Klrc458Q24kbty2PdRaLacHM5z-cZQr8mjeQu3pik6jPSOGAYYFIqBfgmlkgnY0gmlwhDaRWFWHb3BzdGFja4SzlAUAiXNlY3AyNTZrMaECmeSnJh7zjKrDSPoNMGXoopeDF4hhpj5I0OsQUUt4u8uDdGNwgiQGg3VkcIIkBg,enr:-J64QAlTCDa188Hl1OGv5_2Kj2nWCsvxMVc_rEnLtw7RPFbOfqUOV6khXT_PH6cC603I2ynY31rSQ8sI9gLeJbfFGaWGAYYFIrpdgmlkgnY0gmlwhANWgzCHb3BzdGFja4SzlAUAiXNlY3AyNTZrMaECkySjcg-2v0uWAsFsZZu43qNHppGr2D5F913Qqs5jDCGDdGNwgiQGg3VkcIIkBg
export OP_NODE_P2P_LISTEN_IP=0.0.0.0
export OP_NODE_P2P_LISTEN_TCP_PORT=9222
export OP_NODE_P2P_LISTEN_UDP_PORT=9222
export OP_NODE_ROLLUP_CONFIG=./rollup.json
export OP_NODE_RPC_ADDR=0.0.0.0
export OP_NODE_RPC_PORT=9000
export OP_NODE_SNAPSHOT_LOG=/tmp/op-node-snapshot-log
export OP_NODE_VERIFIER_L1_CONFS=4

./node \
  --l1=${OP_NODE_L1_ETH_RPC:="http://0.0.0.0:8545"} \
  --l2=${OP_NODE_L2_ENGINE_RPC:="http://0.0.0.0:9551"} \
  --rollup.config=./rollup.json \
  --l2.jwt-secret=./jwt.hex \
  --rpc.addr=${OP_NODE_RPC_ADDR:="0.0.0.0"} \
  --rpc.port=${OP_NODE_RPC_PORT:=7000} \
  --l1.trustrpc

