#!/usr/bin/make -f
include _common.mk

all: ${PREFIX}/lib/libass$(SHARED_LIBRARY_SUFFIX)

libass/Makefile.am:
	mkdir -p libass && cd libass && git clone https://github.com/libass/libass .

libass/Makefile: libass/Makefile.am
	cd libass && \
	$(autogen_sh) && \
	$(export_build_env_vars) ./configure \
		--prefix=$(PREFIX) \
		--enable-shared

${PREFIX}/lib/libass$(SHARED_LIBRARY_SUFFIX): libass/Makefile
	make -C libass $(MAKE_OPTIONS) install

.PHONY: all
