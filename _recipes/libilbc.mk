#!/usr/bin/make -f

all: ${PREFIX}/lib/libilbc.so

libilbc/CMakeLists.txt:
	mkdir -p libilbc && git clone https://github.com/TimothyGu/libilbc libilbc

libilbc/Makefile: libilbc/CMakeLists.txt
	cd libilbc && \
	LDFLAGS="-L$(PREFIX)/lib" \
	CFLAGS="-I$(PREFIX)/include" \
	CPPFLAGS="-I$(PREFIX)/include" \
	PKG_CONFIG_PATH="$(PREFIX)/lib/pkgconfig:$${PKG_CONFIG_PATH}" \
	cmake -DCMAKE_INSTALL_PREFIX="$(PREFIX)"

$(PREFIX)/lib/libilbc.so: libilbc/Makefile
	make -C libilbc $(MAKE_OPTIONS) install

.PHONY: all
