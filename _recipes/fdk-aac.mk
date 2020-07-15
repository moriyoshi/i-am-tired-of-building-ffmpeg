#!/usr/bin/make -f
include _common.mk

all: ${PREFIX}/lib/libfdk-aac$(SHARED_LIBRARY_SUFFIX)

fdk-aac/Makefile.am:
	mkdir -p fdk-aac && git clone https://github.com/mstorsjo/fdk-aac fdk-aac

fdk-aac/Makefile: fdk-aac/Makefile.am
	cd fdk-aac && \
	$(autogen_sh) \
	$(export_build_env_vars) ./configure \
		--prefix=$(PREFIX) \
		--enable-shared

${PREFIX}/lib/libfdk-aac$(SHARED_LIBRARY_SUFFIX): fdk-aac/Makefile
	make -C fdk-aac ${MAKE_OPTIONS} install

.PHONY: all
