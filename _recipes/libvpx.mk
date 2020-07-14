#!/usr/bin/make -f
LIBVPX_VERSION = 1.8.2
archive = libvpx-$(LIBVPX_VERSION).tar.gz

all: $(PREFIX)/lib/libvpx.so

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "https://github.com/webmproject/libvpx/archive/v$(LIBVPX_VERSION).tar.gz"

libvpx/libvpx-$(LIBVPX_VERSION)/configure: $(TMP)/$(archive)
	mkdir -p libvpx && tar -C libvpx -xvf $(TMP)/$(archive)

libvpx/libvpx-$(LIBVPX_VERSION)/Makefile: libvpx/libvpx-$(LIBVPX_VERSION)/configure
	cd libvpx/libvpx-$(LIBVPX_VERSION) && \
	LDFLAGS="-L$(PREFIX)/lib" \
	CFLAGS="-I$(PREFIX)/include" \
	CPPFLAGS="-I$(PREFIX)/include" \
	PKG_CONFIG_PATH="$(PREFIX)/lib/pkgconfig:$${PKG_CONFIG_PATH}" \
	./configure --prefix=$(PREFIX)

$(PREFIX)/lib/libvpx.so: libvpx/libvpx-$(LIBVPX_VERSION)/Makefile
	make -C libvpx/libvpx-$(LIBVPX_VERSION) install

.PHONY: all
