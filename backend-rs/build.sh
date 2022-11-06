#!/usr/bin/env bash

cross build --release
mkdir -p ../bin
cp ./target/x86_64-unknown-linux-gnu/release/decky_dict_rs ../bin/backend
