#!/usr/bin/make -f
VAMP_PLUGIN_SDK_VERSION = 2.9.0
archive = vamp-plugin-sdk-$(VAMP_PLUGIN_SDK_VERSION).tar.gz

all: $(PREFIX)/lib/libvamp-sdk.so

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "https://code.soundsoftware.ac.uk/attachments/download/2588/vamp-plugin-sdk-$(VAMP_PLUGIN_SDK_VERSION).tar.gz"

vamp-plugin-sdk/vamp-plugin-sdk-$(VAMP_PLUGIN_SDK_VERSION)/configure: $(TMP)/$(archive)
	mkdir -p vamp-plugin-sdk && tar -C vamp-plugin-sdk -xvf $(TMP)/$(archive)

vamp-plugin-sdk/vamp-plugin-sdk-$(VAMP_PLUGIN_SDK_VERSION)/Makefile: vamp-plugin-sdk/vamp-plugin-sdk-$(VAMP_PLUGIN_SDK_VERSION)/configure
	cd vamp-plugin-sdk/vamp-plugin-sdk-$(VAMP_PLUGIN_SDK_VERSION) && \
	LDFLAGS="-L$(PREFIX)/lib" \
	CXXFLAGS="-I$(PREFIX)/include" \
	CPPFLAGS="-I$(PREFIX)/include" \
	PKG_CONFIG_PATH="$(PREFIX)/lib/pkgconfig:$${PKG_CONFIG_PATH}" \
	./configure \
		--prefix=$(PREFIX) \
		--enable-shared \
		--disable-programs

$(PREFIX)/lib/libvamp-sdk.so: vamp-plugin-sdk/vamp-plugin-sdk-$(VAMP_PLUGIN_SDK_VERSION)/Makefile
	LDFLAGS="-L$(PREFIX)/lib" \
	HOST_LIBS="-lsndfile" \
	CXXFLAGS="-I$(PREFIX)/include" \
	CPPFLAGS="-I$(PREFIX)/include" \
	make -C vamp-plugin-sdk/vamp-plugin-sdk-$(VAMP_PLUGIN_SDK_VERSION) install

.PHONY: all
