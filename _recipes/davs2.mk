#!/usr/bin/make -f

all: ${PREFIX}/lib/libdavs2.so

davs2/build/linux/configure:
	mkdir -p davs2 && git clone https://github.com/pkuvcl/davs2 davs2

davs2/build/linux/config.mak: davs2/build/linux/configure
	cd davs2/build/linux && \
	LDFLAGS="-L$(PREFIX)/lib" \
	CFLAGS="-I$(PREFIX)/include" \
	CPPFLAGS="-I$(PREFIX)/include" \
	PKG_CONFIG_PATH="$(PREFIX)/lib/pkgconfig:$${PKG_CONFIG_PATH}" \
	./configure \
		--prefix=${PREFIX} \
		--enable-shared \
		--enable-pic  

${PREFIX}/lib/libdavs2.so: davs2/build/linux/config.mak
	make -C davs2/build/linux ${MAKE_OPTIONS} install

.PHONY: all
