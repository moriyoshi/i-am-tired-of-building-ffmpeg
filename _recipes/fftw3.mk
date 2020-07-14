#!/usr/bin/make -f
FFTW_VERSION = 3.3.8
archive = fftw-$(FFTW_VERSION).tar.gz

all: $(PREFIX)/lib/libfftw3.so

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "http://www.fftw.org/fftw-$(FFTW_VERSION).tar.gz"

fftw/fftw-$(FFTW_VERSION)/configure: $(TMP)/$(archive)
	mkdir -p fftw && tar -C fftw -xvf $(TMP)/$(archive)

fftw/fftw-$(FFTW_VERSION)/Makefile: fftw/fftw-$(FFTW_VERSION)/configure
	cd fftw/fftw-$(FFTW_VERSION) && \
	./configure \
		--prefix=$(PREFIX) \
		--enable-shared

$(PREFIX)/lib/libfftw3.so: fftw/fftw-$(FFTW_VERSION)/Makefile
	make -C fftw/fftw-$(FFTW_VERSION) install

.PHONY: all
