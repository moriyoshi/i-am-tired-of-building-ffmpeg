#!/usr/bin/make -f

all: ${PREFIX}/lib/libvmaf.so

vmaf/meson.build:
	mkdir -p vmaf && cd vmaf && git clone https://github.com/Netflix/vmaf .

vmaf/build/build.ninja: vmaf/meson.build
	cd vmaf && mkdir -p build && cd build && meson --prefix=$(PREFIX) ../libvmaf

${PREFIX}/lib/libvmaf.so: vmaf/build/build.ninja
	cd vmaf/build && ninja install

.PHONY: all
