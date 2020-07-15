#!/usr/bin/make -f
include _common.mk

VAMP_PLUGIN_SDK_VERSION = 2.9.0
archive = vamp-plugin-sdk-$(VAMP_PLUGIN_SDK_VERSION).tar.gz

all: $(PREFIX)/lib/libvamp-sdk$(SHARED_LIBRARY_SUFFIX)

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "https://code.soundsoftware.ac.uk/attachments/download/2588/vamp-plugin-sdk-$(VAMP_PLUGIN_SDK_VERSION).tar.gz"

vamp-plugin-sdk/vamp-plugin-sdk-$(VAMP_PLUGIN_SDK_VERSION)/configure: $(TMP)/$(archive)
	mkdir -p vamp-plugin-sdk && tar -C vamp-plugin-sdk -xvf $(TMP)/$(archive)

vamp-plugin-sdk/vamp-plugin-sdk-$(VAMP_PLUGIN_SDK_VERSION)/Makefile: vamp-plugin-sdk/vamp-plugin-sdk-$(VAMP_PLUGIN_SDK_VERSION)/configure
	cd vamp-plugin-sdk/vamp-plugin-sdk-$(VAMP_PLUGIN_SDK_VERSION) && \
	$(export_build_env_vars) ./configure \
		--prefix=$(PREFIX) \
		--enable-shared

$(PREFIX)/lib/libvamp-sdk$(SHARED_LIBRARY_SUFFIX): vamp-plugin-sdk/vamp-plugin-sdk-$(VAMP_PLUGIN_SDK_VERSION)/Makefile
	make -C vamp-plugin-sdk/vamp-plugin-sdk-$(VAMP_PLUGIN_SDK_VERSION) install

.PHONY: all
