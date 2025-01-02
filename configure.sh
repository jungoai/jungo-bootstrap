. ./node_temp.sh

CHAIN_IMAGE=ghcr.io/mohsennz/jungochain:0.1.0-devnet
BASE_PATH=/var/lib/jungochain

. ./functions.sh                        \
    "$CHAIN_IMAGE"                      \
    "$CHAIN_TYPE"                       \
    "$NODE_NAME"                        \
    "$BASE_PATH"                        \
    "$ADDRESS"                          \
    "$PORT"                             \
    "$RPC_PORT"                         \
    "$NODE_KEY"                         \
    "$TELEMETRY_URL"                    \
    "$PASSWORD"                         \
    "$SECRET_PHRASE"                    \
    "$BOOT_NODES"
