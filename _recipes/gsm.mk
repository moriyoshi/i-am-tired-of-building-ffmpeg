#!/usr/bin/make -f
include _common.mk

GSM_VERSION = 1.0.19
archive_and_dir_name = gsm-$(patsubst %.,%,$(subst . ,.,$(wordlist 1,2,$(subst .,. ,$(GSM_VERSION)))))-pl$(lastword $(subst ., ,$(GSM_VERSION)))
archive = $(archive_and_dir_name).tar.gz

all: $(PREFIX)/lib/libgsm.a

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "http://www.quut.com/gsm/gsm-$(GSM_VERSION).tar.gz"

gsm/$(archive_and_dir_name)/Makefile: $(TMP)/$(archive)
	mkdir -p gsm && tar -C gsm -xvf $(TMP)/$(archive)

$(PREFIX)/lib/libgsm.a: gsm/$(archive_and_dir_name)/Makefile
	cd gsm/$(archive_and_dir_name) && \
	$(export_build_env_vars) make install \
		INSTALL_ROOT="$(PREFIX)" \
		GSM_INSTALL_MAN="$(PREFIX)/share/man/man3" \
		GSM_INSTALL_INC="$(PREFIX)/include"

.PHONY: all
