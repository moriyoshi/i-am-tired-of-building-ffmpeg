#!/usr/bin/make -f
FREETYPE_VERSION = 2.10.2
archive = freetype-$(FREETYPE_VERSION).tar.xz

all: $(PREFIX)/lib/libfreetype.so

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "http://prdownloads.sourceforge.net/freetype/freetype-$(FREETYPE_VERSION).tar.xz"

freetype/freetype-$(FREETYPE_VERSION)/configure: $(TMP)/$(archive)
	mkdir -p freetype && tar -C freetype -xvf $(TMP)/$(archive)

freetype/freetype-$(FREETYPE_VERSION)/Makefile: freetype/freetype-$(FREETYPE_VERSION)/configure
	cd freetype/freetype-$(FREETYPE_VERSION) && \
	./configure \
		--prefix=$(PREFIX) \
		--enable-shared

$(PREFIX)/lib/libfreetype.so: freetype/freetype-$(FREETYPE_VERSION)/Makefile
	make -C freetype/freetype-$(FREETYPE_VERSION) install

.PHONY: all
