#!/usr/bin/make -f
include _common.mk

all: ${PREFIX}/lib/libopenh264$(SHARED_LIBRARY_SUFFIX)

openh264/meson.build:
	mkdir -p openh264 && cd openh264 && git clone https://github.com/cisco/openh264 .

openh264/build/build.ninja: openh264/meson.build
	cd openh264 && mkdir -p build && cd build && meson --prefix=$(PREFIX) ..

${PREFIX}/lib/libopenh264$(SHARED_LIBRARY_SUFFIX): openh264/build/build.ninja
	cd openh264/build && ninja install
	if [ -e "$(PREFIX)/lib64" ]; then \
		cp -R "$(PREFIX)/lib64/"* "$(PREFIX)/lib"; \
		rm -rf "$(PREFIX)/lib64"; \
	fi

.PHONY: all
