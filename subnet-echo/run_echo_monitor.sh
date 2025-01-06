netuid=1001
chain_endpoint="ws://127.0.0.1:9944"
coldkey="miner"
hotkey="default"

jungo-sdk-echo-monitor \
    --subtensor.chain_endpoint  "$chain_endpoint"   \
    --wallet.name               "$coldkey"          \
    --wallet.hotkey             "$hotkey"           \
    --netuid                    "$netuid"           \
    --logging.debug 
