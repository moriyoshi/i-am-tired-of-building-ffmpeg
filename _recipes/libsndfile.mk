#!/usr/bin/make -f
include _common.mk

LIBSNDFILE_VERSION = 1.0.28
archive = libsndfile-$(LIBSNDFILE_VERSION).tar.lzma

all: $(PREFIX)/lib/libsndfile$(SHARED_LIBRARY_SUFFIX)

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "http://www.mega-nerd.com/libsndfile/files/libsndfile-$(LIBSNDFILE_VERSION).tar.gz"

libsndfile/libsndfile-$(LIBSNDFILE_VERSION)/configure: $(TMP)/$(archive)
	mkdir -p libsndfile && tar -C libsndfile -xvf $(TMP)/$(archive)

libsndfile/libsndfile-$(LIBSNDFILE_VERSION)/Makefile: libsndfile/libsndfile-$(LIBSNDFILE_VERSION)/configure
	cd libsndfile/libsndfile-$(LIBSNDFILE_VERSION) && \
	$(export_build_env_vars) ./configure \
		--prefix=$(PREFIX) \
		--enable-shared

$(PREFIX)/lib/libsndfile$(SHARED_LIBRARY_SUFFIX): libsndfile/libsndfile-$(LIBSNDFILE_VERSION)/Makefile
	make -C libsndfile/libsndfile-$(LIBSNDFILE_VERSION) install

.PHONY: all
