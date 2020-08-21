#!/usr/bin/make -f
include _common.mk

all: $(PREFIX)/lib/libaribb24$(SHARED_LIBRARY_SUFFIX)

aribb24/Makefile.am:
	mkdir -p aribb24 && git clone https://github.com/nkoriyama/aribb24 aribb24

aribb24/Makefile: aribb24/Makefile.am
	cd aribb24 && \
	$(autogen_without_autoheader_sh) && \
	$(export_build_env_vars) ./configure \
		--prefix=$(PREFIX) \
		--enable-shared

$(PREFIX)/lib/libaribb24$(SHARED_LIBRARY_SUFFIX): aribb24/Makefile
	make -C aribb24 $(MAKE_OPTIONS) install

.PHONY: all
