#!/usr/bin/make -f

all: $(PREFIX)/bin/ffmpeg

ffmpeg/configure:
	mkdir -p ffmpeg && git clone https://git.ffmpeg.org/ffmpeg.git ffmpeg

ffmpeg/ffbuild/config.sh: ffmpeg/configure
	#  NOTE: license for aribb24 was changed to LGPLv3 and OpenCore AMRs are under Apache License v2. (ffmpeg tells wrong warnings)
	#  --enable-nonfree is for fdk-aac, the license incompatibility would prevent us from redistribution of the binaries
	cd ffmpeg && \
	LD_LIBRARY_PATH="$(PREFIX)/lib" \
	LDFLAGS="-L$(PREFIX)/lib" \
	CFLAGS="-I$(PREFIX)/include" \
	CPPFLAGS="-I$(PREFIX)/include" \
	PKG_CONFIG_PATH="$(PREFIX)/lib/pkgconfig:$${PKG_CONFIG_PATH}" \
	./configure \
		--prefix=$(PREFIX) \
		--enable-gpl \
		--enable-version3 \
		--enable-nonfree \
		--enable-libaribb24 \
		--enable-libopencore-amrnb \
		--enable-libopencore-amrwb \
		--enable-avisynth \
		--enable-libfdk-aac \
		--enable-ladspa \
		--enable-libass \
		--enable-libbs2b \
		--enable-libdav1d \
		--enable-libdavs2 \
		--enable-libfontconfig \
		--enable-libfreetype \
		--enable-libfribidi \
		--enable-libgsm \
		--enable-libilbc \
		--enable-libklvanc \
		--enable-libkvazaar \
		--enable-libmp3lame \
		--enable-libopenh264 \
		--enable-libopenjpeg \
		--enable-libopus \
		--enable-librav1e \
		--enable-librubberband \
		--enable-libsnappy \
		--enable-libsoxr \
		--enable-libspeex \
		--enable-libsrt \
		--enable-libtheora \
		--enable-libvidstab \
		--enable-libvmaf \
		--enable-libvpx \
	#	--enable-chromaprint \
	#	--enable-libaom \
	#	--enable-libbluray \
	#	--enable-libcelt \
	#	--enable-libcdio \
	#	--enable-libcodec2 \
	#	--enable-libdc1394 \
	#	--enable-libflite \
	#	--enable-libglslang \
	#	--enable-libgme \
	#	--enable-libiec61883 \
	#	--enable-libjack \
	#	--enable-liblensfun \
	#	--enable-libmodplug \
	#	--enable-libopencv \
	#	--enable-libopenmpt \
	#	--enable-libopenvino \
	#	--enable-libpulse \
	#	--enable-librabbitmq \
	#	--enable-librsvg \
	#	--enable-librtmp \
	#	--enable-libshine \
	#	--enable-libsmbclient \
	#	--enable-libssh \
	#	--enable-libtensorflow \
	#	--enable-libtesseract \
	#	--enable-libtls \
	#	--enable-libtwolame \
	#	--enable-libv4l2 \
	#	--enable-libvo-amrwbenc \
	#	--enable-libvorbis \

$(PREFIX)/bin/ffmpeg: ffmpeg/ffbuild/config.sh
	LD_LIBRARY_PATH="$(PREFIX)/lib" \
	make -C ffmpeg $(MAKE_OPTIONS) install

.PHONY: all
