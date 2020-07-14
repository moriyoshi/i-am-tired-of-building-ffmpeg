#!/usr/bin/make -f

all: ${PREFIX}/lib/librav1e.so

rav1e/Cargo.toml:
	mkdir -p rav1e && git clone https://github.com/xiph/rav1e rav1e

rav1e/target/release/librav1e.so: rav1e/Cargo.toml
	cd rav1e && \
	PKG_CONFIG_PATH="$(PREFIX)/lib/pkgconfig:$${PKG_CONFIG_PATH}" \
	cargo build --release && \
	cargo cbuild

${PREFIX}/lib/librav1e.so: rav1e/target/release/librav1e.so
	cd rav1e && cargo cinstall --release --prefix=$(PREFIX)

.PHONY: all
