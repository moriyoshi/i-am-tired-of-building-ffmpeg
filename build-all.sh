#!/bin/sh
set -xe
export TMP=${PWD}/_tmp
export PREFIX="${HOME}/opt/ffmpeg"

_recipes/fftw3.mk
_recipes/libsndfile.mk

_recipes/libpng.mk
_recipes/libjpeg-turbo.mk
_recipes/openjpeg.mk
_recipes/fribidi.mk
_recipes/freetype.mk
_recipes/fontconfig.mk

_recipes/aribb24.mk
_recipes/avisynth.mk
_recipes/bs2b.mk
_recipes/dav1d.mk
_recipes/davs2.mk
_recipes/fdk-aac.mk
_recipes/gsm.mk
_recipes/kvazaar.mk
_recipes/ladspa.mk
_recipes/lame.mk
_recipes/libass.mk
_recipes/libilbc.mk
_recipes/libklvanc.mk
_recipes/libvpx.mk
_recipes/ogg.mk
_recipes/opencore-amr.mk
_recipes/openh264.mk
_recipes/opus.mk
_recipes/rav1e.mk
_recipes/snappy.mk
_recipes/soxr.mk
_recipes/speex.mk
_recipes/srt.mk
_recipes/vamp-plugin-sdk.mk
_recipes/vidstab.mk
_recipes/vmaf.mk
_recipes/vorbis.mk
_recipes/theora.mk
_recipes/libsamplerate.mk
_recipes/rubberband.mk
_recipes/ffmpeg.mk
