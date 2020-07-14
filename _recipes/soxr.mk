#!/usr/bin/make -f
SOXR_VERSION = 0.1.3
archive = soxr-$(SOXR_VERSION)-Source.tar.xz

all: $(PREFIX)/lib/libsoxr.so

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "http://prdownloads.sourceforge.net/soxr/soxr-$(SOXR_VERSION)-Source.tar.xz"

soxr/soxr-$(SOXR_VERSION)-Source/CMakeLists.txt: $(TMP)/$(archive)
	mkdir -p soxr && tar -C soxr -xvf $(TMP)/$(archive)

soxr/soxr-$(SOXR_VERSION)-Source/Makefile: soxr/soxr-$(SOXR_VERSION)-Source/CMakeLists.txt
	cd soxr/soxr-$(SOXR_VERSION)-Source && \
	cmake -DBUILD_SHARED_LIBS=1 -DCMAKE_INSTALL_PREFIX=$(PREFIX)

$(PREFIX)/lib/libsoxr.so: soxr/soxr-$(SOXR_VERSION)-Source/Makefile
	make -C soxr/soxr-$(SOXR_VERSION)-Source install

.PHONY: all
