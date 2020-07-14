#!/usr/bin/make -f

all: ${PREFIX}/lib/libopenjp2.so

openjpeg/CMakeLists.txt:
	mkdir -p openjpeg && cd openjpeg && git clone https://github.com/uclouvain/openjpeg .

openjpeg/Makefile: openjpeg/CMakeLists.txt
	cd openjpeg && mkdir -p build && cd build && cmake .. -DCMAKE_INSTALL_PREFIX="$(PREFIX)"

$(PREFIX)/lib/libopenjp2.so: openjpeg/Makefile
	make -C openjpeg/build $(MAKE_OPTIONS) install

.PHONY: all
