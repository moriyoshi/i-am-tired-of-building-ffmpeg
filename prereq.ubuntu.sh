#!/bin/sh
SUDO=${SUDO:-sudo}
${SUDO} apt install -qy curl libz-dev libxml2-dev libssl-dev make gcc g++ libtool automake autoconf cmake pkg-config gperf meson nasm yasm git
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y -v
${HOME}/.cargo/bin/cargo install cargo-c
