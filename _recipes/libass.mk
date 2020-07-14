#!/usr/bin/make -f

all: ${PREFIX}/lib/libass.so

libass/Makefile.am:
	mkdir -p libass && cd libass && git clone https://github.com/libass/libass .

libass/Makefile: libass/Makefile.am
	cd libass && \
	./autogen.sh && \
	LDFLAGS="-L$(PREFIX)/lib" \
	CFLAGS="-I$(PREFIX)/include" \
	CPPFLAGS="-I$(PREFIX)/include" \
	PKG_CONFIG_PATH="$(PREFIX)/lib/pkgconfig:$${PKG_CONFIG_PATH}" \
	./configure \
		--prefix=$(PREFIX) \
		--enable-shared

${PREFIX}/lib/libass.so: libass/Makefile
	make -C libass $(MAKE_OPTIONS) install

.PHONY: all
