#!/usr/bin/make -f

all: $(PREFIX)/include/ladspa.h

$(PREFIX)/include/ladspa.h:
	curl -o $@ https://www.ladspa.org/ladspa_sdk/ladspa.h.txt

.PHONY: all
