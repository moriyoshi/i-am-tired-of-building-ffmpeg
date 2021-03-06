#!/usr/bin/make -f
include _common.mk

all: ${PREFIX}/lib/libavisynth$(SHARED_LIBRARY_SUFFIX)

avisynth/CMakeLists.txt:
	mkdir -p avisynth && cd avisynth && git clone https://github.com/AviSynth/AviSynthPlus .

avisynth/Makefile: avisynth/CMakeLists.txt
	cd avisynth && mkdir -p build && cd build && cmake .. -DHEADERS_ONLY:bool=off -DCMAKE_INSTALL_PREFIX="$(PREFIX)"

$(PREFIX)/lib/libavisynth$(SHARED_LIBRARY_SUFFIX): avisynth/Makefile
	make -C avisynth/build $(MAKE_OPTIONS) install

.PHONY: all
