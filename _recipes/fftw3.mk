#!/usr/bin/make -f
include _common.mk

FFTW_VERSION = 3.3.8
archive = fftw-$(FFTW_VERSION).tar.gz

all: $(PREFIX)/lib/libfftw3$(SHARED_LIBRARY_SUFFIX)

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "http://www.fftw.org/fftw-$(FFTW_VERSION).tar.gz"

fftw/fftw-$(FFTW_VERSION)/configure: $(TMP)/$(archive)
	mkdir -p fftw && tar -C fftw -xvf $(TMP)/$(archive)

fftw/fftw-$(FFTW_VERSION)/Makefile: fftw/fftw-$(FFTW_VERSION)/configure
	cd fftw/fftw-$(FFTW_VERSION) && \
	$(export_build_env_vars) ./configure \
		--prefix=$(PREFIX) \
		--enable-shared

$(PREFIX)/lib/libfftw3$(SHARED_LIBRARY_SUFFIX): fftw/fftw-$(FFTW_VERSION)/Makefile
	make -C fftw/fftw-$(FFTW_VERSION) install

.PHONY: all
