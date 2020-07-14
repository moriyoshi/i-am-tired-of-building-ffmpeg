#!/usr/bin/make -f
THEORA_VERSION = 1.1.1
archive = libtheora-$(THEORA_VERSION).tar.bz2

all: $(PREFIX)/lib/libtheora.so

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "http://downloads.xiph.org/releases/theora/libtheora-$(THEORA_VERSION).tar.bz2"

theora/libtheora-$(THEORA_VERSION)/configure: $(TMP)/$(archive)
	mkdir -p theora && tar -C theora -xvf $(TMP)/$(archive)

theora/libtheora-$(THEORA_VERSION)/Makefile: theora/libtheora-$(THEORA_VERSION)/configure
	cd theora/libtheora-$(THEORA_VERSION) && \
	LDFLAGS="-L$(PREFIX)/lib" \
	CFLAGS="-I$(PREFIX)/include" \
	CPPFLAGS="-I$(PREFIX)/include" \
	PKG_CONFIG_PATH="$(PREFIX)/lib/pkgconfig:$${PKG_CONFIG_PATH}" \
	./configure \
		--prefix=$(PREFIX) \
		--enable-shared \
		--disable-examples

$(PREFIX)/lib/libtheora.so: theora/libtheora-$(THEORA_VERSION)/Makefile
	make -C theora/libtheora-$(THEORA_VERSION) install

.PHONY: all
