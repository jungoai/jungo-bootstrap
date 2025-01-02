chain_bin=$1
chain_type=$2
node_name=$3
address=$4
port=$5
rpc_port=$6
node_key=$7
telemetry_url=$8
password=$9
secret_phrase=${10}
boot_nodes=${11}

base_path=temp/"$node_name"
chain_spec=./"$chain_type"_spec.json
chain_spec_raw="${chain_spec%.*}"_raw.json

export_spec() {
    "$chain_bin" build-spec \
        --disable-default-bootnode                      \
        --chain "$chain_type"                           \
        > "$chain_spec"
}

spec_to_raw() {
    "$chain_bin" build-spec                             \
        --chain "$chain_spec"                           \
        --raw                                           \
        --disable-default-bootnode                      \
        > "$chain_spec_raw"
}

export_raw_spec() {
    export_spec
    spec_to_raw
}

add_keys_to_keystore() {
    "$chain_bin" key insert                             \
        --base-path "$base_path"                        \
        --chain     "$chain_spec_raw"                   \
        --scheme    Sr25519                             \
        --suri      "$secret_phrase"                    \
        --password  "$password"                         \
        --key-type  aura

    "$chain_bin" key insert                             \
        --base-path "$base_path"                        \
        --chain     "$chain_spec_raw"                   \
        --scheme    Ed25519                             \
        --suri      "$secret_phrase"                    \
        --password  "$password"                         \
        --key-type  gran
}

run_boot_validator_node_() {
    "$chain_bin"                                        \
        --validator                                     \
        --base-path     "$base_path"                    \
        --chain         "$chain_spec_raw"               \
        --name          "$node_name"                    \
        --public-addr   /ip4/"$address"/tcp/"$port"     \
        --port          "$port"                         \
        --rpc-port      "$rpc_port"                     \
        --node-key      "$node_key"                     \
        --rpc-methods   Unsafe                          \
        --telemetry-url "$telemetry_url"                \
        --password      "$password"
}

run_validator_node_() {
    "$chain_bin"                                        \
        --validator                                     \
        --base-path     "$base_path"                    \
        --chain         "$chain_spec_raw"               \
        --name          "$node_name"                    \
        --public-addr   /ip4/"$address"/tcp/"$port"     \
        --port          "$port"                         \
        --rpc-port      "$rpc_port"                     \
        --node-key      "$node_key"                     \
        --rpc-methods   Unsafe                          \
        --password      "$password"                     \
        --bootnodes     "$boot_nodes"
}

run_boot_validator_node() {
    add_keys_to_keystore
    run_boot_validator_node_
}

run_validator_node() {
    add_keys_to_keystore
    run_validator_node_
}

# Reference:
# https://docs.substrate.io/deploy/prepare-to-deploy/#common-deployment-targets

# boot, validator, rpc
run_node01_() {
    "$chain_bin"                                                \
        --validator                                             \
        --base-path             "$base_path"                    \
        --chain                 "$chain_spec_raw"               \
        --name                  "$node_name"                    \
        --node-key              "$node_key"                     \
        --public-addr           /ip4/"$address"/tcp/"$port"     \
        --port                  "$port"                         \
        --rpc-port              "$rpc_port"                     \
        --rpc-methods           Safe                            \
        --unsafe-rpc-external                                   \
        --rpc-cors              all                             \
        --rpc-max-connections   5000                            \
        --telemetry-url         "$telemetry_url"                \
        --password              "$password"
}

add_keys1() {
    ./target/release/jungochain-node key insert                             \
        --base-path ./temp/node01                        \
        --chain     ./devnet_spec_raw.json                   \
        --scheme    Sr25519                             \
        --suri      "bottom flag assume dolphin guide inflict peanut average dutch endless planet above"                    \
        --password  110110110                         \
        --key-type  aura

    ./target/release/jungochain-node key insert                             \
        --base-path ./temp/node01                        \
        --chain     ./devnet_spec_raw.json                   \
        --scheme    Ed25519                             \
        --suri      "bottom flag assume dolphin guide inflict peanut average dutch endless planet above"                    \
        --password  110110110                         \
        --key-type  gran
}

add_keys2() {
    ./target/release/jungochain-node key insert                             \
        --base-path ./temp/node02                        \
        --chain     ./devnet_spec_raw.json                   \
        --scheme    Sr25519                             \
        --suri      "hunt holiday relief term resource aspect enforce bike midnight major predict domain"                    \
        --password  110110110                         \
        --key-type  aura

    ./target/release/jungochain-node key insert                             \
        --base-path ./temp/node02                        \
        --chain     ./devnet_spec_raw.json                   \
        --scheme    Ed25519                             \
        --suri      "hunt holiday relief term resource aspect enforce bike midnight major predict domain"                \
        --password  110110110                         \
        --key-type  gran
}

run1() {
    ./target/release/jungochain-node                             \
        --validator                                             \
        --base-path             ./temp/node01                    \
        --chain                 ./devnet_spec_raw.json          \
        --name                  node01                    \
        --node-key              dc0134267a35e46f91f4c956aa880b468486bd6d73e917580ba827d6d81fa25a      \
        --public-addr           /ip4/127.0.0.1/tcp/30333     \
        --port                  30333                        \
        --rpc-port              9944                     \
        --rpc-methods           Safe                            \
        --unsafe-rpc-external                                   \
        --rpc-cors              all                             \
        --rpc-max-connections   5000                            \
        --password              110110110
}

run2() {
    ./target/release/jungochain-node                             \
        --validator                                             \
        --base-path             ./temp/node02                    \
        --chain                 ./devnet_spec_raw.json          \
        --name                  node02                    \
        --node-key              fa85dc25513ce98edde930d65564c3e9df2f148597c0aadcab97bebf50b945e5      \
        --public-addr           /ip4/127.0.0.1/tcp/30334     \
        --port                  30334                        \
        --rpc-port              9945                     \
        --rpc-methods           Safe                            \
        --unsafe-rpc-external                                   \
        --rpc-cors              all                             \
        --rpc-max-connections   5000                            \
        --password              110110110
}

# boot, validator, rpc
run_node02_() {
    "$chain_bin"                                                \
        --validator                                             \
        --base-path             "$base_path"                    \
        --chain                 "$chain_spec_raw"               \
        --name                  "$node_name"                    \
        --node-key              "$node_key"                     \
        --public-addr           /ip4/"$address"/tcp/"$port"     \
        --port                  "$port"                         \
        --rpc-port              "$rpc_port"                     \
        --rpc-methods           Safe                            \
        --unsafe-rpc-external                                   \
        --rpc-cors              all                             \
        --rpc-max-connections   5000                            \
        --bootnodes             "$boot_nodes"                   \
        --password              "$password"
}

# validator, rpc
run_node03_() {
    "$chain_bin"                                                \
        --validator                                             \
        --base-path             "$base_path"                    \
        --chain                 "$chain_spec_raw"               \
        --name                  "$node_name"                    \
        --node-key              "$node_key"                     \
        --public-addr           /ip4/"$address"/tcp/"$port"     \
        --port                  "$port"                         \
        --rpc-port              "$rpc_port"                     \
        --rpc-methods           Safe                            \
        --unsafe-rpc-external                                   \
        --rpc-cors              all                             \
        --rpc-max-connections   5000                            \
        --bootnodes             "$boot_nodes"                   \
        --password              "$password"
}

# validator, rpc
run_node04_() {
    "$chain_bin"                                                \
        --validator                                             \
        --base-path             "$base_path"                    \
        --chain                 "$chain_spec_raw"               \
        --name                  "$node_name"                    \
        --node-key              "$node_key"                     \
        --public-addr           /ip4/"$address"/tcp/"$port"     \
        --port                  "$port"                         \
        --rpc-port              "$rpc_port"                     \
        --rpc-methods           Safe                            \
        --unsafe-rpc-external                                   \
        --rpc-cors              all                             \
        --rpc-max-connections   5000                            \
        --bootnodes             "$boot_nodes"                   \
        --password              "$password"
}

# validator, rpc, archive
run_node05_() {
    "$chain_bin"                                                \
        --validator                                             \
        --base-path             "$base_path"                    \
        --chain                 "$chain_spec_raw"               \
        --name                  "$node_name"                    \
        --node-key              "$node_key"                     \
        --public-addr           /ip4/"$address"/tcp/"$port"     \
        --port                  "$port"                         \
        --rpc-port              "$rpc_port"                     \
        --rpc-methods           Safe                            \
        --unsafe-rpc-external                                   \
        --rpc-cors              all                             \
        --rpc-max-connections   5000                            \
        --state-pruning         archive                         \
        --bootnodes             "$boot_nodes"                   \
        --password              "$password"
}

run_node01() {
    export_raw_spec
    add_keys_to_keystore
    run_node01_
}
run_node02() {
    export_raw_spec
    add_keys_to_keystore
    run_node02_
}
run_node03() {
    export_raw_spec
    add_keys_to_keystore
    run_node03_
}
run_node04() {
    export_raw_spec
    add_keys_to_keystore
    run_node04_
}
run_node05() {
    export_raw_spec
    add_keys_to_keystore
    run_node05_
}

export -f export_spec
export -f spec_to_raw
export -f export_raw_spec
export -f spec_to_raw
export -f run_boot_validator_node
export -f run_validator_node
