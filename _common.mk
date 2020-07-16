ifeq ($(shell uname -s),Darwin)
SHARED_LIBRARY_SUFFIX = .dylib
else
SHARED_LIBRARY_SUFFIX = .so
endif

ifneq ($(shell which glibtoolize),)
libtoolize = glibtoolize
else
libtoolize = libtoolize
endif

autogen_sh = \
	$(libtoolize) -c -f -i && \
	aclocal -I m4 && \
	autoheader && \
	automake -c -a -i && \
	autoconf

export_build_env_vars = \
	LDFLAGS="-L$(PREFIX)/lib" \
	CFLAGS="-I$(PREFIX)/include" \
	CXXFLAGS="-I$(PREFIX)/include" \
	CPPFLAGS="-I$(PREFIX)/include" \
	PKG_CONFIG_PATH="$(PREFIX)/lib/pkgconfig:$${PKG_CONFIG_PATH}"
