#!/usr/bin/make -f
include _common.mk

LIBVPX_VERSION = 1.8.2
archive = libvpx-$(LIBVPX_VERSION).tar.gz

all: $(PREFIX)/lib/libvpx$(SHARED_LIBRARY_SUFFIX)

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "https://github.com/webmproject/libvpx/archive/v$(LIBVPX_VERSION).tar.gz"

libvpx/libvpx-$(LIBVPX_VERSION)/configure: $(TMP)/$(archive)
	mkdir -p libvpx && tar -C libvpx -xvf $(TMP)/$(archive)

libvpx/libvpx-$(LIBVPX_VERSION)/Makefile: libvpx/libvpx-$(LIBVPX_VERSION)/configure
	cd libvpx/libvpx-$(LIBVPX_VERSION) && \
	$(export_build_env_vars) ./configure --prefix=$(PREFIX)

$(PREFIX)/lib/libvpx$(SHARED_LIBRARY_SUFFIX): libvpx/libvpx-$(LIBVPX_VERSION)/Makefile
	make -C libvpx/libvpx-$(LIBVPX_VERSION) install

.PHONY: all
