#!/usr/bin/make -f 
include _common.mk

PYTHON3 := python3

all: meson/bin/meson

meson/bin/pip:
	$(PYTHON3) -m venv meson

meson/bin/meson: meson/bin/pip
	"meson/bin/pip" install meson
