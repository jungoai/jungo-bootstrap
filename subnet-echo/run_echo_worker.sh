#!/bin/bash

ip="192.168.100.129"
port=4000
netuid=1001
chain_endpoint="ws://127.0.0.1:9944"
coldkey="worker"
hotkey="default"

jungo-sdk-echo-worker \
    --ip                        "$ip"               \
    --port                      "$port"             \
    --netuid                    "$netuid"           \
    --subtensor.chain_endpoint  "$chain_endpoint"   \
    --wallet.name               "$coldkey"          \
    --wallet.hotkey             "$hotkey"           \
    --logging.debug 
