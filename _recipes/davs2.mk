#!/usr/bin/make -f
include _common.mk

all: ${PREFIX}/lib/libdavs2$(SHARED_LIBRARY_SUFFIX)

davs2/build/linux/configure:
	mkdir -p davs2 && git clone https://github.com/pkuvcl/davs2 davs2

davs2/build/linux/config.mak: davs2/build/linux/configure
	cd davs2/build/linux && \
	$(export_build_env_vars) ./configure \
		--prefix=${PREFIX} \
		--enable-shared \
		--enable-pic  

${PREFIX}/lib/libdavs2$(SHARED_LIBRARY_SUFFIX): davs2/build/linux/config.mak
	make -C davs2/build/linux ${MAKE_OPTIONS} install

.PHONY: all
