#!/usr/bin/env bash

trap killgroup SIGINT

killgroup(){
  echo killing...
  kill 0
}

$1 | sed  "s/^/[$2] /" &
$3 | sed  "s/^/[$4] /" &
wait
