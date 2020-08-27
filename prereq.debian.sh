#!/bin/bash
set -xe
SUDO=${SUDO:-sudo}
${SUDO} apt install -qy curl libz-dev libxml2-dev libssl-dev make gcc g++ libtool automake autoconf cmake pkg-config gperf nasm yasm git python3 python3-venv re2c
TMP=${PWD}/_tmp
export TMP
mkdir -p "${TMP}" && _recipes/meson.mk && _recipes/ninja.mk
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y -v
${HOME}/.cargo/bin/cargo install cargo-c
