#!/usr/bin/make -f
include _common.mk

OGG_VERSION = 1.3.1
archive = libogg-$(OGG_VERSION).tar.gz

all: $(PREFIX)/lib/libogg$(SHARED_LIBRARY_SUFFIX)

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "http://downloads.xiph.org/releases/ogg/libogg-$(OGG_VERSION).tar.gz"

ogg/libogg-$(OGG_VERSION)/configure: $(TMP)/$(archive)
	mkdir -p ogg && tar -C ogg -xvf $(TMP)/$(archive)

ogg/libogg-$(OGG_VERSION)/Makefile: ogg/libogg-$(OGG_VERSION)/configure
	cd ogg/libogg-$(OGG_VERSION) && \
	$(export_build_env_vars) ./configure \
		--prefix=$(PREFIX) \
		--enable-shared

$(PREFIX)/lib/libogg$(SHARED_LIBRARY_SUFFIX): ogg/libogg-$(OGG_VERSION)/Makefile
	make -C ogg/libogg-$(OGG_VERSION) $(MAKE_OPTIONS) install

.PHONY: all
