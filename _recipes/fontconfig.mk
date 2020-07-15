#!/usr/bin/make -f
include _common.mk

FONTCONFIG_VERSION = 2.13.92
archive = fontconfig-$(FONTCONFIG_VERSION).tar.xz

all: $(PREFIX)/lib/libfontconfig$(SHARED_LIBRARY_SUFFIX)

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "https://www.freedesktop.org/software/fontconfig/release/fontconfig-$(FONTCONFIG_VERSION).tar.xz"

fontconfig/fontconfig-$(FONTCONFIG_VERSION)/configure: $(TMP)/$(archive)
	mkdir -p fontconfig && tar -C fontconfig -xvf $(TMP)/$(archive)

fontconfig/fontconfig-$(FONTCONFIG_VERSION)/Makefile: fontconfig/fontconfig-$(FONTCONFIG_VERSION)/configure
	cd fontconfig/fontconfig-$(FONTCONFIG_VERSION) && \
	$(export_build_env_vars) ./configure \
		--prefix=$(PREFIX) \
		--enable-shared \
		--enable-libxml2

$(PREFIX)/lib/libfontconfig$(SHARED_LIBRARY_SUFFIX): fontconfig/fontconfig-$(FONTCONFIG_VERSION)/Makefile
	make -C fontconfig/fontconfig-$(FONTCONFIG_VERSION) install

.PHONY: all
