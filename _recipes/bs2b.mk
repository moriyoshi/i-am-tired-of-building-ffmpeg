#!/usr/bin/make -f
include _common.mk

BS2B_VERSION = 3.1.0
archive = libbs2b-$(BS2B_VERSION).tar.lzma

all: $(PREFIX)/lib/libbs2b$(SHARED_LIBRARY_SUFFIX)

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "http://prdownloads.sourceforge.net/bs2b/libbs2b/$(BS2B_VERSION)/libbs2b-$(BS2B_VERSION).tar.lzma"

bs2b/libbs2b-$(BS2B_VERSION)/configure: $(TMP)/$(archive)
	mkdir -p bs2b && tar -C bs2b -xvf $(TMP)/$(archive)

bs2b/libbs2b-$(BS2B_VERSION)/Makefile: bs2b/libbs2b-$(BS2B_VERSION)/configure
	cd bs2b/libbs2b-$(BS2B_VERSION) && \
	$(export_build_env_vars) ./configure \
		--prefix=$(PREFIX) \
		--enable-shared

$(PREFIX)/lib/libbs2b$(SHARED_LIBRARY_SUFFIX): bs2b/libbs2b-$(BS2B_VERSION)/Makefile
	make -C bs2b/libbs2b-$(BS2B_VERSION) install

.PHONY: all
