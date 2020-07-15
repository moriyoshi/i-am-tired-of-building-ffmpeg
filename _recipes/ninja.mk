#!/usr/bin/make -f
include _common.mk

NINJA_VERSION=1.10.0
PYTHON3:=python3
archive=ninja-$(NINJA_VERSION).tar.gz

all: ninja/ninja-$(NINJA_VERSION)/ninja

ninja/ninja-$(NINJA_VERSION)/configure.py:
	curl -L -o "$(TMP)/$(archive)" "https://github.com/ninja-build/ninja/archive/v$(NINJA_VERSION).tar.gz"
	mkdir -p ninja && tar -C ninja -xvf "$(TMP)/$(archive)"

ninja/ninja-$(NINJA_VERSION)/ninja: ninja/ninja-$(NINJA_VERSION)/configure.py
	$(PYTHON3) ninja/ninja-$(NINJA_VERSION)/configure.py --bootstrap
