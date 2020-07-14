#!/bin/sh
sudo apt install -qy libz-dev libxml2-dev libssl-dev gcc g++ libtool automake autoconf gperf meson nasm yasm
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y -v
cargo install cargo-c
