#!/usr/bin/make -f
include _common.mk

LAME_VERSION = 3.100
archive = lame-$(LAME_VERSION).tar.gz

all: $(PREFIX)/lib/libmp3lame$(SHARED_LIBRARY_SUFFIX)

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "http://prdownloads.sourceforge.net/lame/lame/$(LAME_VERSION)/lame-$(LAME_VERSION).tar.gz"

lame/lame-$(LAME_VERSION)/configure: $(TMP)/$(archive)
	mkdir -p lame && tar -C lame -xvf $(TMP)/$(archive)

lame/lame-$(LAME_VERSION)/Makefile: lame/lame-$(LAME_VERSION)/configure
	cd lame/lame-$(LAME_VERSION) && \
	$(export_build_env_vars) ./configure \
		--prefix=$(PREFIX) \
		--enable-shared

$(PREFIX)/lib/libmp3lame$(SHARED_LIBRARY_SUFFIX): lame/lame-$(LAME_VERSION)/Makefile
	sed -i -e '/lame_init_old/ d' "lame/lame-$(LAME_VERSION)/include/libmp3lame.sym"
	make -C lame/lame-$(LAME_VERSION) install

.PHONY: all
