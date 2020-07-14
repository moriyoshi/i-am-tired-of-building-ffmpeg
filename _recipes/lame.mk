#!/usr/bin/make -f
LAME_VERSION = 3.100
archive = lame-$(LAME_VERSION).tar.gz

all: $(PREFIX)/lib/libmp3lame.so

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "http://prdownloads.sourceforge.net/lame/lame/$(LAME_VERSION)/lame-$(LAME_VERSION).tar.gz"

lame/lame-$(LAME_VERSION)/configure: $(TMP)/$(archive)
	mkdir -p lame && tar -C lame -xvf $(TMP)/$(archive)

lame/lame-$(LAME_VERSION)/Makefile: lame/lame-$(LAME_VERSION)/configure
	cd lame/lame-$(LAME_VERSION) && \
	./configure \
		--prefix=$(PREFIX) \
		--enable-shared

$(PREFIX)/lib/libmp3lame.so: lame/lame-$(LAME_VERSION)/Makefile
	make -C lame/lame-$(LAME_VERSION) install

.PHONY: all
