#!/usr/bin/make -f
include _common.mk

VIDSTAB_VERSION = 1.1.0
archive = vidstab-$(VIDSTAB_VERSION).tar.gz

all: $(PREFIX)/lib/libvidstab$(SHARED_LIBRARY_SUFFIX)

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "https://github.com/georgmartius/vid.stab/archive/v$(VIDSTAB_VERSION).tar.gz"

vidstab/vid.stab-$(VIDSTAB_VERSION)/CMakeLists.txt: $(TMP)/$(archive)
	mkdir -p vidstab && tar -C vidstab -xvf $(TMP)/$(archive)

vidstab/vid.stab-$(VIDSTAB_VERSION)/Makefile: vidstab/vid.stab-$(VIDSTAB_VERSION)/CMakeLists.txt
	cd vidstab/vid.stab-$(VIDSTAB_VERSION) && \
	$(export_build_env_vars) cmake -DCMAKE_INSTALL_PREFIX=$(PREFIX) -DUSE_OMP=off

$(PREFIX)/lib/libvidstab$(SHARED_LIBRARY_SUFFIX): vidstab/vid.stab-$(VIDSTAB_VERSION)/Makefile
	make -C vidstab/vid.stab-$(VIDSTAB_VERSION) install

.PHONY: all
