#!/usr/bin/make -f
include _common.mk

FREETYPE_VERSION = 2.10.2
archive = freetype-$(FREETYPE_VERSION).tar.xz

all: $(PREFIX)/lib/libfreetype$(SHARED_LIBRARY_SUFFIX)

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "http://prdownloads.sourceforge.net/freetype/freetype-$(FREETYPE_VERSION).tar.xz"

freetype/freetype-$(FREETYPE_VERSION)/builds/unix/configure: $(TMP)/$(archive)
	mkdir -p freetype && tar -C freetype -xvf $(TMP)/$(archive)

freetype/freetype-$(FREETYPE_VERSION)/Makefile: freetype/freetype-$(FREETYPE_VERSION)/builds/unix/configure
	cd freetype/freetype-$(FREETYPE_VERSION) && \
	$(export_build_env_vars) ./configure \
		--prefix=$(PREFIX) \
		--enable-shared

$(PREFIX)/lib/libfreetype$(SHARED_LIBRARY_SUFFIX): freetype/freetype-$(FREETYPE_VERSION)/Makefile
	make -C freetype/freetype-$(FREETYPE_VERSION) install

.PHONY: all
