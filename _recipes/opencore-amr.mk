#!/usr/bin/make -f
OPENCORE_AMR_VERSION = 0.1.5
archive = opencore-amr-$(OPENCORE_AMR_VERSION).tar.gz

all: $(PREFIX)/lib/libopencore-amrnb.so

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "http://prdownloads.sourceforge.net/opencore-amr/opencore-amr-$(OPENCORE_AMR_VERSION).tar.gz"

opencore-amr/opencore-amr-$(OPENCORE_AMR_VERSION)/configure: $(TMP)/$(archive)
	mkdir -p opencore-amr && tar -C opencore-amr -xvf $(TMP)/$(archive)

opencore-amr/opencore-amr-$(OPENCORE_AMR_VERSION)/Makefile: opencore-amr/opencore-amr-$(OPENCORE_AMR_VERSION)/configure
	cd opencore-amr/opencore-amr-$(OPENCORE_AMR_VERSION) && \
	./configure \
		--prefix=$(PREFIX) \
		--enable-shared

$(PREFIX)/lib/libopencore-amrnb.so: opencore-amr/opencore-amr-$(OPENCORE_AMR_VERSION)/Makefile
	make -C opencore-amr/opencore-amr-$(OPENCORE_AMR_VERSION) install

.PHONY: all
