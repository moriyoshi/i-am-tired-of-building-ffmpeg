#!/usr/bin/make -f
include _common.mk

all: ${PREFIX}/lib/librubberband$(SHARED_LIBRARY_SUFFIX)

rubberband/Makefile.in:
	mkdir -p rubberband && git clone https://github.com/breakfastquay/rubberband rubberband

rubberband/Makefile: rubberband/Makefile.in
	cd rubberband && \
	aclocal && \
	autoconf && \
	sed -i -e 's/-Wl,-Bsymbolic //g; s/-Wl,-soname=[^ ]*//g; s/-Wl,--version-script=[^ ]*//g;' Makefile.in && \
	$(export_build_env_vars) ./configure \
		--prefix=$(PREFIX) \
		--enable-shared

${PREFIX}/lib/librubberband$(SHARED_LIBRARY_SUFFIX): rubberband/Makefile
	make -C rubberband ${MAKE_OPTIONS} install

.PHONY: all
