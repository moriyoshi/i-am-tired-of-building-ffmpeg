#!/usr/bin/make -f
include _common.mk

LIBJPEG_TURBO_VERSION = 2.0.5
archive = libjpeg-turbo-$(LIBJPEG_TURBO_VERSION).tar.gz

all: $(PREFIX)/lib/libturbojpeg$(SHARED_LIBRARY_SUFFIX)

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "https://sourceforge.net/projects/libjpeg-turbo/files/2.0.5/libjpeg-turbo-$(LIBJPEG_TURBO_VERSION).tar.gz"

libjpeg-turbo/libjpeg-turbo-$(LIBJPEG_TURBO_VERSION)/CMakeLists.txt: $(TMP)/$(archive)
	mkdir -p libjpeg-turbo && tar -C libjpeg-turbo -xvf $(TMP)/$(archive)

libjpeg-turbo/libjpeg-turbo-$(LIBJPEG_TURBO_VERSION)/Makefile: libjpeg-turbo/libjpeg-turbo-$(LIBJPEG_TURBO_VERSION)/CMakeLists.txt
	cd libjpeg-turbo/libjpeg-turbo-$(LIBJPEG_TURBO_VERSION) && \
	cmake -DCMAKE_INSTALL_PREFIX="$(PREFIX)"	

$(PREFIX)/lib/libturbojpeg$(SHARED_LIBRARY_SUFFIX): libjpeg-turbo/libjpeg-turbo-$(LIBJPEG_TURBO_VERSION)/Makefile
	make -C libjpeg-turbo/libjpeg-turbo-$(LIBJPEG_TURBO_VERSION) $(MAKE_OPTIONS) install

.PHONY: all
