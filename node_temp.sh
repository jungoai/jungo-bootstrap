CHAIN_BIN=./target/release/jungochain-node

# To show in telemetry UI
# E.g: node01, node02, node03
NODE_NAME="node01"

# Wallet secret phrase of auth keys
SECRET_PHRASE="xxxx xxx xxxxx xxxxxx xxxxxx xxxxx xxx xxxxxx xxxxxx xxxx xxxx xxxx"

# Wallet password of auth keys
PASSWORD=110110110

ADDRESS="0.0.0.0"

PORT=30333

RPC_PORT=9945

# generted by `<chain-bin> key generate-node-key`
NODE_KEY="b41f7b58d1bd9cb8f2db1d2fb595c04fae002f6f91995031afe30d4c2bb09323"

CHAIN_TYPE=devnet

TELEMETRY_URL="wss://telemetry.polkadot.io/submit/ 0"

# It used if node is a participant node
BOOT_NODES="/ip4/127.0.0.1/tcp/30333/p2p/12D3KooWP88qe2pt79EpyMeqqRHuN2K1YMufvL3rzWcJ3CRYtUag"
#            |   ^ip       |   ^port |   ^peer node id
#            ^ip-version   ^protocol ^p2p
