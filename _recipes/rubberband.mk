#!/usr/bin/make -f

all: ${PREFIX}/lib/librubberband.so

rubberband/Makefile.am:
	mkdir -p rubberband && git clone https://github.com/breakfastquay/rubberband rubberband

rubberband/Makefile: rubberband/Makefile.am
	cd rubberband && \
	aclocal && \
	autoconf && \
	LDFLAGS="-L$(PREFIX)/lib" \
	CFLAGS="-I$(PREFIX)/include" \
	CPPFLAGS="-I$(PREFIX)/include" \
	PKG_CONFIG_PATH="$(PREFIX)/lib/pkgconfig:$${PKG_CONFIG_PATH}" \
	./configure \
		--prefix=$(PREFIX) \
		--enable-shared

${PREFIX}/lib/librubberband.so: rubberband/Makefile
	make -C rubberband ${MAKE_OPTIONS} install

.PHONY: all
