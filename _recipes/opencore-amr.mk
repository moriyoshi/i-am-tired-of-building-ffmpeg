#!/usr/bin/make -f
include _common.mk

OPENCORE_AMR_VERSION = 0.1.5
archive = opencore-amr-$(OPENCORE_AMR_VERSION).tar.gz

all: $(PREFIX)/lib/libopencore-amrnb$(SHARED_LIBRARY_SUFFIX)

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "http://prdownloads.sourceforge.net/opencore-amr/opencore-amr-$(OPENCORE_AMR_VERSION).tar.gz"

opencore-amr/opencore-amr-$(OPENCORE_AMR_VERSION)/configure: $(TMP)/$(archive)
	mkdir -p opencore-amr && tar -C opencore-amr -xvf $(TMP)/$(archive)

opencore-amr/opencore-amr-$(OPENCORE_AMR_VERSION)/Makefile: opencore-amr/opencore-amr-$(OPENCORE_AMR_VERSION)/configure
	cd opencore-amr/opencore-amr-$(OPENCORE_AMR_VERSION) && \
	$(export_build_env_vars) ./configure \
		--prefix=$(PREFIX) \
		--enable-shared

$(PREFIX)/lib/libopencore-amrnb$(SHARED_LIBRARY_SUFFIX): opencore-amr/opencore-amr-$(OPENCORE_AMR_VERSION)/Makefile
	make -C opencore-amr/opencore-amr-$(OPENCORE_AMR_VERSION) install

.PHONY: all
