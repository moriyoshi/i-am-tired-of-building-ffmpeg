#!/usr/bin/make -f
FRIBIDI_VERSION = 1.0.10
archive = fribidi-$(FRIBIDI_VERSION).tar.gz

all: $(PREFIX)/lib/libfribidi.so

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "https://github.com/fribidi/fribidi/archive/v$(FRIBIDI_VERSION).tar.gz"

fribidi/fribidi-$(FRIBIDI_VERSION)/configure: $(TMP)/$(archive)
	mkdir -p fribidi && tar -C fribidi -xvf $(TMP)/$(archive)

fribidi/fribidi-$(FRIBIDI_VERSION)/Makefile: fribidi/fribidi-$(FRIBIDI_VERSION)/configure
	cd fribidi/fribidi-$(FRIBIDI_VERSION) && \
	./autogen.sh && \
	LDFLAGS="-L$(PREFIX)/lib" \
	CFLAGS="-I$(PREFIX)/include" \
	CPPFLAGS="-I$(PREFIX)/include" \
	PKG_CONFIG_PATH="$(PREFIX)/lib/pkgconfig:$${PKG_CONFIG_PATH}" \
	./configure \
		--prefix=$(PREFIX) \
		--enable-shared

$(PREFIX)/lib/libfribidi.so: fribidi/fribidi-$(FRIBIDI_VERSION)/Makefile
	make -C fribidi/fribidi-$(FRIBIDI_VERSION) install

.PHONY: all
