#!/usr/bin/make -f
include _common.mk

all: ${PREFIX}/lib/libkvazaar$(SHARED_LIBRARY_SUFFIX)

kvazaar/Makefile.am:
	mkdir -p kvazaar
	cd kvazaar
	git clone https://github.com/ultravideo/kvazaar .
	git submodule update --init --depth 1

kvazaar/Makefile: kvazaar/Makefile.am
	cd kvazaar && \
	$(autogen_sh) && \
	$(export_build_env_vars) ./configure \
		--prefix=$(PREFIX) \
		--enable-shared

${PREFIX}/lib/libkvazaar$(SHARED_LIBRARY_SUFFIX): kvazaar/Makefile
	make -C kvazaar ${MAKE_OPTIONS} install

.PHONY: all
