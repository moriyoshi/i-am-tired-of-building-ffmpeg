#!/usr/bin/make -f
include _common.mk

OPENSSL_VERSION = 1.1.1g
archive = openssl-$(OPENSSL_VERSION).tar.gz

all: $(PREFIX)/lib/libssl$(SHARED_LIBRARY_SUFFIX)

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "https://www.openssl.org/source/openssl-$(OPENSSL_VERSION).tar.gz"

openssl/openssl-$(OPENSSL_VERSION)/Configure: $(TMP)/$(archive)
	mkdir -p openssl && tar -C openssl -xvf $(TMP)/$(archive)

openssl/openssl-$(OPENSSL_VERSION)/Configurations: openssl/openssl-$(OPENSSL_VERSION)/Configure
	cd openssl/openssl-$(OPENSSL_VERSION) && \
	./Configure shared threads --prefix="$(PREFIX)" cc

$(PREFIX)/lib/libssl$(SHARED_LIBRARY_SUFFIX): openssl/openssl-$(OPENSSL_VERSION)/Configurations
	make -C openssl/openssl-$(OPENSSL_VERSION) $(MAKE_OPTIONS) install

.PHONY: all
