#!/usr/bin/make -f
LIBSNDFILE_VERSION = 1.0.28
archive = libsndfile-$(LIBSNDFILE_VERSION).tar.lzma

all: $(PREFIX)/lib/libsndfile.so

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "http://www.mega-nerd.com/libsndfile/files/libsndfile-$(LIBSNDFILE_VERSION).tar.gz"

libsndfile/libsndfile-$(LIBSNDFILE_VERSION)/configure: $(TMP)/$(archive)
	mkdir -p libsndfile && tar -C libsndfile -xvf $(TMP)/$(archive)

libsndfile/libsndfile-$(LIBSNDFILE_VERSION)/Makefile: libsndfile/libsndfile-$(LIBSNDFILE_VERSION)/configure
	cd libsndfile/libsndfile-$(LIBSNDFILE_VERSION) && \
	LDFLAGS="-L$(PREFIX)/lib" \
	CFLAGS="-I$(PREFIX)/include" \
	CPPFLAGS="-I$(PREFIX)/include" \
	PKG_CONFIG_PATH="$(PREFIX)/lib/pkgconfig:$${PKG_CONFIG_PATH}" \
	./configure \
		--prefix=$(PREFIX) \
		--enable-shared

$(PREFIX)/lib/libsndfile.so: libsndfile/libsndfile-$(LIBSNDFILE_VERSION)/Makefile
	make -C libsndfile/libsndfile-$(LIBSNDFILE_VERSION) install

.PHONY: all
