#!/usr/bin/make -f
BS2B_VERSION = 3.1.0
archive = libbs2b-$(BS2B_VERSION).tar.lzma

all: $(PREFIX)/lib/libbs2b.so

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "http://prdownloads.sourceforge.net/bs2b/libbs2b/$(BS2B_VERSION)/libbs2b-$(BS2B_VERSION).tar.lzma"

bs2b/libbs2b-$(BS2B_VERSION)/configure: $(TMP)/$(archive)
	mkdir -p bs2b && tar -C bs2b -xvf $(TMP)/$(archive)

bs2b/libbs2b-$(BS2B_VERSION)/Makefile: bs2b/libbs2b-$(BS2B_VERSION)/configure
	cd bs2b/libbs2b-$(BS2B_VERSION) && \
	LDFLAGS="-L$(PREFIX)/lib" \
	CFLAGS="-I$(PREFIX)/include" \
	CPPFLAGS="-I$(PREFIX)/include" \
	PKG_CONFIG_PATH="$(PREFIX)/lib/pkgconfig:$${PKG_CONFIG_PATH}" \
	./configure \
		--prefix=$(PREFIX) \
		--enable-shared

$(PREFIX)/lib/libbs2b.so: bs2b/libbs2b-$(BS2B_VERSION)/Makefile
	make -C bs2b/libbs2b-$(BS2B_VERSION) install

.PHONY: all
