#!/usr/bin/make -f
include _common.mk

LIBSAMPLERATE_VERSION = 0.1.9
archive = libsamplerate-$(LIBSAMPLERATE_VERSION).tar.gz

all: $(PREFIX)/lib/libsamplerate$(SHARED_LIBRARY_SUFFIX)

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "http://www.mega-nerd.com/SRC/libsamplerate-$(LIBSAMPLERATE_VERSION).tar.gz"

libsamplerate/libsamplerate-$(LIBSAMPLERATE_VERSION)/configure: $(TMP)/$(archive)
	mkdir -p libsamplerate && tar -C libsamplerate -xvf $(TMP)/$(archive)

libsamplerate/libsamplerate-$(LIBSAMPLERATE_VERSION)/Makefile: libsamplerate/libsamplerate-$(LIBSAMPLERATE_VERSION)/configure
	cd libsamplerate/libsamplerate-$(LIBSAMPLERATE_VERSION) && \
	$(export_build_env_vars) ./configure \
		--prefix=$(PREFIX) \
		--enable-shared \
		--disable-sndfile

$(PREFIX)/lib/libsamplerate$(SHARED_LIBRARY_SUFFIX): libsamplerate/libsamplerate-$(LIBSAMPLERATE_VERSION)/Makefile
	make -C libsamplerate/libsamplerate-$(LIBSAMPLERATE_VERSION) install

.PHONY: all
