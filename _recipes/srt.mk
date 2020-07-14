#!/usr/bin/make -f
SRT_VERSION = 1.4.1
archive = srt-$(SRT_VERSION).tar.gz

all: $(PREFIX)/lib/libsrt.so

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "https://github.com/Haivision/srt/archive/v$(SRT_VERSION).tar.gz"

srt/srt-$(SRT_VERSION)/CMakeLists.txt: $(TMP)/$(archive)
	mkdir -p srt && tar -C srt -xvf $(TMP)/$(archive)

srt/srt-$(SRT_VERSION)/Makefile: srt/srt-$(SRT_VERSION)/CMakeLists.txt
	cd srt/srt-$(SRT_VERSION) && \
	cmake -DBUILD_SHARED_LIBS=1 -DCMAKE_INSTALL_PREFIX=$(PREFIX)

$(PREFIX)/lib/libsrt.so: srt/srt-$(SRT_VERSION)/Makefile
	make -C srt/srt-$(SRT_VERSION) install

.PHONY: all
