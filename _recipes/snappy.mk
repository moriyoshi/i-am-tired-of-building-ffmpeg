#!/usr/bin/make -f
SNAPPY_VERSION = 1.1.8
archive = snappy-$(SNAPPY_VERSION).tar.gz

all: $(PREFIX)/lib/libsnappy.so

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "https://github.com/google/snappy/archive/$(SNAPPY_VERSION).tar.gz"

snappy/snappy-$(SNAPPY_VERSION)/CMakeLists.txt: $(TMP)/$(archive)
	mkdir -p snappy && tar -C snappy -xvf $(TMP)/$(archive)

snappy/snappy-$(SNAPPY_VERSION)/Makefile: snappy/snappy-$(SNAPPY_VERSION)/CMakeLists.txt
	cd snappy/snappy-$(SNAPPY_VERSION) && \
	cmake -DBUILD_SHARED_LIBS=1 -DCMAKE_INSTALL_PREFIX=$(PREFIX)

$(PREFIX)/lib/libsnappy.so: snappy/snappy-$(SNAPPY_VERSION)/Makefile
	make -C snappy/snappy-$(SNAPPY_VERSION) install

.PHONY: all
