#!/usr/bin/make -f
LIBPNG_VERSION = 1.6.37
archive = libpng-$(LIBPNG_VERSION).tar.xz

all: $(PREFIX)/lib/libpng.so

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "http://prdownloads.sourceforge.net/libpng/libpng-$(LIBPNG_VERSION).tar.xz"

libpng/libpng-$(LIBPNG_VERSION)/configure: $(TMP)/$(archive)
	mkdir -p libpng && tar -C libpng -xvf $(TMP)/$(archive)

libpng/libpng-$(LIBPNG_VERSION)/Makefile: libpng/libpng-$(LIBPNG_VERSION)/configure
	cd libpng/libpng-$(LIBPNG_VERSION) && \
	./configure \
		--prefix=$(PREFIX) \
		--enable-shared

$(PREFIX)/lib/libpng.so: libpng/libpng-$(LIBPNG_VERSION)/Makefile
	make -C libpng/libpng-$(LIBPNG_VERSION) install

.PHONY: all
