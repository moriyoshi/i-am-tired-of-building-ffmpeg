#!/usr/bin/make -f
include _common.mk

all: $(PREFIX)/include/ladspa.h

$(PREFIX)/include/ladspa.h:
	curl -o $@ https://www.ladspa.org/ladspa_sdk/ladspa.h.txt

.PHONY: all
