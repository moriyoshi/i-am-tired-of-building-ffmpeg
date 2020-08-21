#!/usr/bin/make -f
include _common.mk

all: ${PREFIX}/lib/libklvanc$(SHARED_LIBRARY_SUFFIX)

libklvanc/Makefile.am:
	mkdir -p libklvanc && git clone https://github.com/stoth68000/libklvanc libklvanc

libklvanc/Makefile: libklvanc/Makefile.am
	cd libklvanc && \
	$(autogen_without_autoheader_sh) && \
	$(export_build_env_vars) ./configure \
		--prefix=$(PREFIX) \
		--enable-shared

${PREFIX}/lib/libklvanc$(SHARED_LIBRARY_SUFFIX): libklvanc/Makefile
	make -C libklvanc ${MAKE_OPTIONS} install

.PHONY: all
