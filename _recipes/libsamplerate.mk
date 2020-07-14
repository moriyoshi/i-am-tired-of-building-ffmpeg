#!/usr/bin/make -f
LIBSAMPLERATE_VERSION = 0.1.9
archive = libsamplerate-$(LIBSAMPLERATE_VERSION).tar.gz

all: $(PREFIX)/lib/libsamplerate.so

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "http://www.mega-nerd.com/SRC/libsamplerate-$(LIBSAMPLERATE_VERSION).tar.gz"

libsamplerate/libsamplerate-$(LIBSAMPLERATE_VERSION)/configure: $(TMP)/$(archive)
	mkdir -p libsamplerate && tar -C libsamplerate -xvf $(TMP)/$(archive)

libsamplerate/libsamplerate-$(LIBSAMPLERATE_VERSION)/Makefile: libsamplerate/libsamplerate-$(LIBSAMPLERATE_VERSION)/configure
	cd libsamplerate/libsamplerate-$(LIBSAMPLERATE_VERSION) && \
	./configure \
		--prefix=$(PREFIX) \
		--enable-shared

$(PREFIX)/lib/libsamplerate.so: libsamplerate/libsamplerate-$(LIBSAMPLERATE_VERSION)/Makefile
	make -C libsamplerate/libsamplerate-$(LIBSAMPLERATE_VERSION) install

.PHONY: all
