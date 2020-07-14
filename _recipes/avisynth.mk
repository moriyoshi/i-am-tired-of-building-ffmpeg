#!/usr/bin/make -f

all: ${PREFIX}/lib/libavisynth.so

avisynth/CMakeLists.txt:
	mkdir -p avisynth && cd avisynth && git clone https://github.com/AviSynth/AviSynthPlus .

avisynth/Makefile: avisynth/CMakeLists.txt
	cd avisynth && mkdir -p build && cd build && cmake .. -DHEADERS_ONLY:bool=off -DCMAKE_INSTALL_PREFIX="$(PREFIX)"

$(PREFIX)/lib/libavisynth.so: avisynth/Makefile
	make -C avisynth/build $(MAKE_OPTIONS) install

.PHONY: all
