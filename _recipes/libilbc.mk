#!/usr/bin/make -f
include _common.mk

all: ${PREFIX}/lib/libilbc$(SHARED_LIBRARY_SUFFIX)

libilbc/CMakeLists.txt:
	mkdir -p libilbc && git clone https://github.com/TimothyGu/libilbc libilbc

libilbc/Makefile: libilbc/CMakeLists.txt
	cd libilbc && \
	$(export_build_env_vars) cmake -DCMAKE_INSTALL_PREFIX="$(PREFIX)"

$(PREFIX)/lib/libilbc$(SHARED_LIBRARY_SUFFIX): libilbc/Makefile
	make -C libilbc $(MAKE_OPTIONS) install
	if [ -e "$(PREFIX)/lib64" ]; then \
		cp -R "$(PREFIX)/lib64/"* "$(PREFIX)/lib"; \
		rm -rf "$(PREFIX)/lib64"; \
	fi

.PHONY: all
