#!/usr/bin/make -f
VORBIS_VERSION = 1.3.3
archive = libvorbis-$(VORBIS_VERSION).tar.gz

all: $(PREFIX)/lib/libvorbis.so

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "http://downloads.xiph.org/releases/vorbis/libvorbis-$(VORBIS_VERSION).tar.gz"

vorbis/libvorbis-$(VORBIS_VERSION)/configure: $(TMP)/$(archive)
	mkdir -p vorbis && tar -C vorbis -xvf $(TMP)/$(archive)

vorbis/libvorbis-$(VORBIS_VERSION)/Makefile: vorbis/libvorbis-$(VORBIS_VERSION)/configure
	cd vorbis/libvorbis-$(VORBIS_VERSION) && \
	./configure \
		--prefix=$(PREFIX) \
		--enable-shared

$(PREFIX)/lib/libvorbis.so: vorbis/libvorbis-$(VORBIS_VERSION)/Makefile
	make -C vorbis/libvorbis-$(VORBIS_VERSION) install

.PHONY: all
