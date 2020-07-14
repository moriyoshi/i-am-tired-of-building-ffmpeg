#!/usr/bin/make -f
VIDSTAB_VERSION = 1.1.0
archive = vidstab-$(VIDSTAB_VERSION).tar.gz

all: $(PREFIX)/lib/libvidstab.so

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "https://github.com/georgmartius/vid.stab/archive/v$(VIDSTAB_VERSION).tar.gz"

vidstab/vidstab-$(VIDSTAB_VERSION)/CMakeLists.txt: $(TMP)/$(archive)
	mkdir -p vidstab && tar -C vidstab -xvf $(TMP)/$(archive)

vidstab/vid.stab-$(VIDSTAB_VERSION)/Makefile: vidstab/vid.stab-$(VIDSTAB_VERSION)/CMakeLists.txt
	cd vidstab/vid.stab-$(VIDSTAB_VERSION) && \
	LDFLAGS="-L$(PREFIX)/lib" \
	CFLAGS="-I$(PREFIX)/include" \
	CPPFLAGS="-I$(PREFIX)/include" \
	PKG_CONFIG_PATH="$(PREFIX)/lib/pkgconfig:$${PKG_CONFIG_PATH}" \
	cmake -DCMAKE_INSTALL_PREFIX=$(PREFIX)

$(PREFIX)/lib/libvidstab.so: vidstab/vid.stab-$(VIDSTAB_VERSION)/Makefile
	make -C vidstab/vid.stab-$(VIDSTAB_VERSION) install

.PHONY: all
