#!/usr/bin/env bash

# Wait for initialization via download
function downwait() {
  while [ ! -f /shared/initialized.txt ]; do
    echo "Waiting for initialization..."
    sleep 10
  done
}

