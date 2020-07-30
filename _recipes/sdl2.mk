#!/usr/bin/make -f
include _common.mk

SDL_VERSION = 2.0.12
archive = SDL2-$(SDL_VERSION).tar.gz

all: $(PREFIX)/lib/libsdl2$(SHARED_LIBRARY_SUFFIX)

$(TMP)/$(archive):
	curl -L -o $(TMP)/$(archive) "https://www.libsdl.org/release/SDL2-$(SDL_VERSION).tar.gz"

sdl2/SDL2-$(SDL_VERSION)/configure: $(TMP)/$(archive)
	mkdir -p sdl2 && tar -C sdl2 -xvf $(TMP)/$(archive)

sdl2/SDL2-$(SDL_VERSION)/Makefile: sdl2/SDL2-$(SDL_VERSION)/configure
	cd sdl2/SDL2-$(SDL_VERSION) && \
	./configure \
		--prefix=$(PREFIX) \
		--enable-shared

$(PREFIX)/lib/libsdl2$(SHARED_LIBRARY_SUFFIX): sdl2/SDL2-$(SDL_VERSION)/Makefile
	make -C sdl2/SDL2-$(SDL_VERSION) install

.PHONY: all
