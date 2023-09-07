#!/bin/sh

dir=$(dirname "$0")

# Read the block number from user input to rewind to
read -p "Enter the block number to rewind to [default: 4012900]\n" B
B=${B:-4012900}
echo "Using block number: $B"

# Execute the rewind command
dir/reth stage unwind to-block $B --datadir dir/op_reth
