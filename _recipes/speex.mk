#!/usr/bin/make -f
SPEEX_VERSION = 1.2.0
archive = speex-$(SPEEX_VERSION).tar.gz

all: $(PREFIX)/lib/libspeex.so

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "http://downloads.us.xiph.org/releases/speex/speex-$(SPEEX_VERSION).tar.gz"

speex/speex-$(SPEEX_VERSION)/configure: $(TMP)/$(archive)
	mkdir -p speex && tar -C speex -xvf $(TMP)/$(archive)

speex/speex-$(SPEEX_VERSION)/Makefile: speex/speex-$(SPEEX_VERSION)/configure
	cd speex/speex-$(SPEEX_VERSION) && \
	./configure \
		--prefix=$(PREFIX) \
		--enable-shared

$(PREFIX)/lib/libspeex.so: speex/speex-$(SPEEX_VERSION)/Makefile
	make -C speex/speex-$(SPEEX_VERSION) install

.PHONY: all
