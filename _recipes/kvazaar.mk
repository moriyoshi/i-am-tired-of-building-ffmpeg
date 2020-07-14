#!/usr/bin/make -f

all: ${PREFIX}/lib/libkvazaar.so

kvazaar/Makefile.am:
	mkdir -p kvazaar && git clone https://github.com/ultravideo/kvazaar kvazaar

kvazaar/Makefile: kvazaar/Makefile.am
	cd kvazaar && \
	./autogen.sh && \
	LDFLAGS="-L$(PREFIX)/lib" \
	CFLAGS="-I$(PREFIX)/include" \
	CPPFLAGS="-I$(PREFIX)/include" \
	PKG_CONFIG_PATH="$(PREFIX)/lib/pkgconfig:$${PKG_CONFIG_PATH}" \
	./configure \
		--prefix=$(PREFIX) \
		--enable-shared

${PREFIX}/lib/libkvazaar.so: kvazaar/Makefile
	make -C kvazaar ${MAKE_OPTIONS} install

.PHONY: all
