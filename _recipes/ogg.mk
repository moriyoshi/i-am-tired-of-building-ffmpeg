#!/usr/bin/make -f
OGG_VERSION = 1.3.1
archive = libogg-$(OGG_VERSION).tar.gz

all: $(PREFIX)/lib/libogg.so

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "http://downloads.xiph.org/releases/ogg/libogg-$(OGG_VERSION).tar.gz"

ogg/libogg-$(OGG_VERSION)/configure: $(TMP)/$(archive)
	mkdir -p ogg && tar -C ogg -xvf $(TMP)/$(archive)

ogg/libogg-$(OGG_VERSION)/Makefile: ogg/libogg-$(OGG_VERSION)/configure
	cd ogg/libogg-$(OGG_VERSION) && \
	./configure \
		--prefix=$(PREFIX) \
		--enable-shared

$(PREFIX)/lib/libogg.so: ogg/libogg-$(OGG_VERSION)/Makefile
	make -C ogg/libogg-$(OGG_VERSION) install

.PHONY: all
