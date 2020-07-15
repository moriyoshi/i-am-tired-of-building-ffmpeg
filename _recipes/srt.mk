#!/usr/bin/make -f
include _common.mk

SRT_VERSION = 1.4.1
archive = srt-$(SRT_VERSION).tar.gz

all: $(PREFIX)/lib/libsrt$(SHARED_LIBRARY_SUFFIX)

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "https://github.com/Haivision/srt/archive/v$(SRT_VERSION).tar.gz"

srt/srt-$(SRT_VERSION)/CMakeLists.txt: $(TMP)/$(archive)
	mkdir -p srt && tar -C srt -xvf $(TMP)/$(archive)

srt/srt-$(SRT_VERSION)/Makefile: srt/srt-$(SRT_VERSION)/CMakeLists.txt
	cd srt/srt-$(SRT_VERSION) && \
	$(export_build_env_vars) cmake -DBUILD_SHARED_LIBS=1 -DCMAKE_INSTALL_PREFIX=$(PREFIX) .

$(PREFIX)/lib/libsrt$(SHARED_LIBRARY_SUFFIX): srt/srt-$(SRT_VERSION)/Makefile
	$(export_build_env_vars) make -C srt/srt-$(SRT_VERSION) install

.PHONY: all
