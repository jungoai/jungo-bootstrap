chain_image=$1
chain_type=$2
node_name=$3
base_path_=$4
address=$5
port=$6
rpc_port=$7
node_key=$8
telemetry_url=$9
password=${10}
secret_phrase=${11}
boot_nodes=${12}

base_path="$base_path_/$node_name"
chain_spec="$base_path_/$chain_type"_spec.json
chain_spec_raw="${chain_spec%.*}"_raw.json

log_max_size="10m"
log_max_file=10

# docker run -p "$port":"$port" -p "$rpc_port":"$rpc_port" -v "$base_path_":"$base_path_" "$chain_image"
# docker run -v "$base_path_":"$base_path_" "$chain_image"

mkdir -p "$base_path_"

export_spec() {
    docker run -v "$base_path_":"$base_path_" "$chain_image" \
        build-spec                                      \
        --disable-default-bootnode                      \
        --chain "$chain_type"                           \
        > "$chain_spec"
}

spec_to_raw() {
    docker run -v "$base_path_":"$base_path_" "$chain_image" \
        build-spec                                      \
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
    docker run -v "$base_path_":"$base_path_" "$chain_image" \
        key         insert                              \
        --base-path "$base_path"                        \
        --chain     "$chain_spec_raw"                   \
        --scheme    Sr25519                             \
        --suri      "$secret_phrase"                    \
        --password  "$password"                         \
        --key-type  aura

    docker run -v "$base_path_":"$base_path_" "$chain_image" \
        key         insert                              \
        --base-path "$base_path"                        \
        --chain     "$chain_spec_raw"                   \
        --scheme    Ed25519                             \
        --suri      "$secret_phrase"                    \
        --password  "$password"                         \
        --key-type  gran
}

# Reference:
# https://docs.substrate.io/deploy/prepare-to-deploy/#common-deployment-targets

# boot, validator, rpc
run_node01_() {
    docker run                                      \
        -p              "$port:$port"               \
        -p              "$rpc_port:$rpc_port"       \
        -v              "$base_path_:$base_path_"   \
        --log-driver    json-file                   \
        --log-opt       max-size="$log_max_size"    \
        --log-opt       max-file="$log_max_file"    \
        -d                                          \
        "$chain_image"                              \
        \
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

# boot, validator, rpc
run_node02_() {
    docker run                                      \
        -p              "$port:$port"               \
        -p              "$rpc_port:$rpc_port"       \
        -v              "$base_path_:$base_path_"   \
        --log-driver    json-file                   \
        --log-opt       max-size="$log_max_size"    \
        --log-opt       max-file="$log_max_file"    \
        -d                                          \
        "$chain_image"                              \
        \
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
    docker run                                      \
        -p              "$port:$port"               \
        -p              "$rpc_port:$rpc_port"       \
        -v              "$base_path_:$base_path_"   \
        --log-driver    json-file                   \
        --log-opt       max-size="$log_max_size"    \
        --log-opt       max-file="$log_max_file"    \
        -d                                          \
        "$chain_image"                              \
        \
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
    docker run                                      \
        -p              "$port:$port"               \
        -p              "$rpc_port:$rpc_port"       \
        -v              "$base_path_:$base_path_"   \
        --log-driver    json-file                   \
        --log-opt       max-size="$log_max_size"    \
        --log-opt       max-file="$log_max_file"    \
        -d                                          \
        "$chain_image"                              \
        \
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
    docker run                                      \
        -p              "$port:$port"               \
        -p              "$rpc_port:$rpc_port"       \
        -v              "$base_path_:$base_path_"   \
        --log-driver    json-file                   \
        --log-opt       max-size="$log_max_size"    \
        --log-opt       max-file="$log_max_file"    \
        -d                                          \
        "$chain_image"                              \
        \
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
