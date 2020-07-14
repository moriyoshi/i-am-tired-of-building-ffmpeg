#!/usr/bin/make -f

all: ${PREFIX}/lib/libklvanc.so

libklvanc/Makefile.am:
	mkdir -p libklvanc && git clone https://github.com/stoth68000/libklvanc libklvanc

libklvanc/Makefile: libklvanc/Makefile.am
	cd libklvanc && \
	./autogen.sh --build && \
	LDFLAGS="-L$(PREFIX)/lib" \
	CFLAGS="-I$(PREFIX)/include" \
	CPPFLAGS="-I$(PREFIX)/include" \
	PKG_CONFIG_PATH="$(PREFIX)/lib/pkgconfig:$${PKG_CONFIG_PATH}" \
	./configure \
		--prefix=$(PREFIX) \
		--enable-shared

${PREFIX}/lib/libklvanc.so: libklvanc/Makefile
	make -C libklvanc ${MAKE_OPTIONS} install

.PHONY: all
