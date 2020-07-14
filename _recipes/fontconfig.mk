#!/usr/bin/make -f
FONTCONFIG_VERSION = 2.13.92
archive = fontconfig-$(FONTCONFIG_VERSION).tar.xz

all: $(PREFIX)/lib/libfontconfig.so

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "https://www.freedesktop.org/software/fontconfig/release/fontconfig-$(FONTCONFIG_VERSION).tar.xz"

fontconfig/fontconfig-$(FONTCONFIG_VERSION)/configure: $(TMP)/$(archive)
	mkdir -p fontconfig && tar -C fontconfig -xvf $(TMP)/$(archive)

fontconfig/fontconfig-$(FONTCONFIG_VERSION)/Makefile: fontconfig/fontconfig-$(FONTCONFIG_VERSION)/configure
	cd fontconfig/fontconfig-$(FONTCONFIG_VERSION) && \
	LDFLAGS="-L$(PREFIX)/lib" \
	CFLAGS="-I$(PREFIX)/include" \
	CPPFLAGS="-I$(PREFIX)/include" \
	PKG_CONFIG_PATH="$(PREFIX)/lib/pkgconfig:$${PKG_CONFIG_PATH}" \
	./configure \
		--prefix=$(PREFIX) \
		--enable-shared \
		--enable-libxml2

$(PREFIX)/lib/libfontconfig.so: fontconfig/fontconfig-$(FONTCONFIG_VERSION)/Makefile
	make -C fontconfig/fontconfig-$(FONTCONFIG_VERSION) install

.PHONY: all
