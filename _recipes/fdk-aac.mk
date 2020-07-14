#!/usr/bin/make -f

all: ${PREFIX}/lib/libfdk-aac.so

fdk-aac/Makefile.am:
	mkdir -p fdk-aac && git clone https://github.com/mstorsjo/fdk-aac fdk-aac

fdk-aac/Makefile: fdk-aac/Makefile.am
	cd fdk-aac && \
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

${PREFIX}/lib/libfdk-aac.so: fdk-aac/Makefile
	make -C fdk-aac ${MAKE_OPTIONS} install

.PHONY: all
