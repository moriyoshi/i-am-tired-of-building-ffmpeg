#!/bin/sh
export _TMP=${PWD}/tmp

_recipes/meson.mk
_recipes/ninja.mk

export PATH=meson/bin:${PATH}
export PATH=ninja:${PATH}

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y -v
${HOME}/.cargo/bin/cargo install cargo-c
