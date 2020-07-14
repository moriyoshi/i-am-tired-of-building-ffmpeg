#!/usr/bin/make -f

all: $(PREFIX)/lib/libaribb24.so

aribb24/Makefile.am:
	mkdir -p aribb24 && git clone https://github.com/nkoriyama/aribb24 aribb24

aribb24/Makefile: aribb24/Makefile.am
	cd aribb24 && \
	libtoolize -c -f && \
	aclocal && \
	automake -c -a -i && \
	autoconf && \
	LDFLAGS="-L$(PREFIX)/lib" \
	CFLAGS="-I$(PREFIX)/include" \
	CPPFLAGS="-I$(PREFIX)/include" \
	PKG_CONFIG_PATH="$(PREFIX)/lib/pkgconfig:$${PKG_CONFIG_PATH}" \
	./configure \
		--prefix=$(PREFIX) \
		--enable-shared

$(PREFIX)/lib/libaribb24.so: aribb24/Makefile
	make -C aribb24 $(MAKE_OPTIONS) install

.PHONY: all
