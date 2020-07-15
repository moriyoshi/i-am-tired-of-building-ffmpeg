#!/usr/bin/make -f
include _common.mk

all: $(PREFIX)/lib/libvmaf$(SHARED_LIBRARY_SUFFIX)

vmaf/libvmaf/meson.build:
	mkdir -p vmaf && cd vmaf && git clone https://github.com/Netflix/vmaf .

vmaf/build/build.ninja: vmaf/libvmaf/meson.build
	cd vmaf && mkdir -p build && cd build && meson --prefix=$(PREFIX) ../libvmaf

$(PREFIX)/lib/libvmaf$(SHARED_LIBRARY_SUFFIX): vmaf/build/build.ninja
	cd vmaf/build && ninja install

.PHONY: all
