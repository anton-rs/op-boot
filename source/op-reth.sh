#!/usr/bin/env bash

./reth node \
  --datadir ${OP_RETH__DATADIR:="op_reth"} \
  --chain ${OP_RETH__NETWORK_NAME:="base-goerli"} \
  --http \
  --http.addr ${OP_RETH__HTTP_ADDR:="0.0.0.0"} \
  --http.port ${OP_RETH__HTTP_PORT:=9545} \
  --http.api ${OP_RETH__HTTP_API:="admin,debug,eth,net,trace,txpool,web3,rpc"} \
  --ws \
  --ws.addr ${OP_RETH__WS_ADDR:="0.0.0.0"} \
  --ws.port ${OP_RETH__WS_PORT:=9546} \
  --ws.api ${OP_RETH__WS_API:="admin,debug,eth,net,trace,txpool,web3,rpc"} \
  --authrpc.addr ${OP_RETH__AUTHRPC_ADDR:="0.0.0.0"} \
  --authrpc.port ${OP_RETH__AUTHRPC_PORT:=9551} \
  --authrpc.jwtsecret ${OP_RETH__AUTHRPC_JWT_SECRET:="jwt.txt"} \
  --port ${OP_RETH__PORT:=30304} \
  --discovery.port ${OP_RETH__DISCOVERY_PORT:=30304} \
  --rollup.sequencer-http ${OP_RETH__ROLLUP_SEQUENCER_HTTP:="https://goerli-sequencer.base.org"} \
  -vvvvv
