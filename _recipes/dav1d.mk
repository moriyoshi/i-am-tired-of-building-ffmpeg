#!/usr/bin/make -f

all: $(PREFIX)/lib/libdav1d.so

dav1d/meson.build:
	mkdir -p dav1d && cd dav1d && git clone https://code.videolan.org/videolan/dav1d .

dav1d/build/build.ninja: dav1d/meson.build
	cd dav1d && mkdir -p build && cd build && meson --prefix=$(PREFIX) ..

$(PREFIX)/lib/libdav1d.so: dav1d/build/build.ninja
	cd dav1d/build && ninja install
	cp -R $(PREFIX)/lib64/* $(PREFIX)/lib
	rm -rf $(PREFIX)/lib64

.PHONY: all
