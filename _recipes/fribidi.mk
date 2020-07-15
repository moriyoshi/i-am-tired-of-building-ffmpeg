#!/usr/bin/make -f
include _common.mk

FRIBIDI_VERSION = 1.0.10
archive = fribidi-$(FRIBIDI_VERSION).tar.gz

all: $(PREFIX)/lib/libfribidi$(SHARED_LIBRARY_SUFFIX)

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "https://github.com/fribidi/fribidi/archive/v$(FRIBIDI_VERSION).tar.gz"

fribidi/fribidi-$(FRIBIDI_VERSION)/configure: $(TMP)/$(archive)
	mkdir -p fribidi && tar -C fribidi -xvf $(TMP)/$(archive)

fribidi/fribidi-$(FRIBIDI_VERSION)/Makefile: fribidi/fribidi-$(FRIBIDI_VERSION)/configure
	cd fribidi/fribidi-$(FRIBIDI_VERSION) && \
	$(autogen_sh) \
	$(export_build_env_vars) ./configure \
		--prefix=$(PREFIX) \
		--enable-shared

$(PREFIX)/lib/libfribidi$(SHARED_LIBRARY_SUFFIX): fribidi/fribidi-$(FRIBIDI_VERSION)/Makefile
	make -C fribidi/fribidi-$(FRIBIDI_VERSION) install

.PHONY: all
