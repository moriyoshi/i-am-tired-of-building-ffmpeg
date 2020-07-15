#!/usr/bin/make -f
include _common.mk

all: ${PREFIX}/lib/librav1e$(SHARED_LIBRARY_SUFFIX)

rav1e/Cargo.toml:
	mkdir -p rav1e && git clone https://github.com/xiph/rav1e rav1e

rav1e/target/release/librav1e$(SHARED_LIBRARY_SUFFIX): rav1e/Cargo.toml
	cd rav1e && \
	$(export_build_env_vars) \
	cargo build --release && \
	cargo cbuild

${PREFIX}/lib/librav1e$(SHARED_LIBRARY_SUFFIX): rav1e/target/release/librav1e$(SHARED_LIBRARY_SUFFIX)
	cd rav1e && cargo cinstall --release --prefix=$(PREFIX)

.PHONY: all
