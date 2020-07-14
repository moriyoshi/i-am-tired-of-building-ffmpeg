#!/usr/bin/make -f
OPUS_VERSION = 1.3.1
archive = opus-$(OPUS_VERSION).tar.gz

all: $(PREFIX)/lib/libopus.so

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "https://archive.mozilla.org/pub/opus/opus-$(OPUS_VERSION).tar.gz"

opus/opus-$(OPUS_VERSION)/configure: $(TMP)/$(archive)
	mkdir -p opus && tar -C opus -xvf $(TMP)/$(archive)

opus/opus-$(OPUS_VERSION)/Makefile: opus/opus-$(OPUS_VERSION)/configure
	cd opus/opus-$(OPUS_VERSION) && \
	./configure \
		--prefix=$(PREFIX) \
		--enable-shared

$(PREFIX)/lib/libopus.so: opus/opus-$(OPUS_VERSION)/Makefile
	make -C opus/opus-$(OPUS_VERSION) install

.PHONY: all
