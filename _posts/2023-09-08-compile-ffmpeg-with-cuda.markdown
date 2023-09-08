---
layout: post
title: Compile ffmpeg with CUDA
date: 2023-09-08
categories: [computer]
tags: [CUDA,ffmpeg]
mathjax: false
---

It is very helpful for us to compile our own ffmpeg, if we own a NVIDIA graphics card. Then those routine tasks such as screen recording using VokoscreenNG, video conference using Wemeet, movie editing using Kdenlive, animation export from Paraview, etc. can all be accelerated and relieve the burden on CPU.

My graphics card is NVIDIA RTX A2000. I&rsquo;ve installed the NVIDIA driver version 515.65.01 and CUDA version 11.7, which can be checked by calling the command `nvidia-smi`. With this information, I went to [ffmpeg Git repository](https://git.videolan.org/?p=ffmpeg.git;a=summary), checked the commit messages, from which I knew [this commit](https://git.videolan.org/?p=ffmpeg.git;a=commit;h=ac0408522aa68444be28e4e691bfa61ab963c617) supports CUDA SDK 11.1. So I checked out this version of `ffmpeg`. Next, I visited [nv-codec-headers git repository](https://git.videolan.org/?p=ffmpeg/nv-codec-headers.git;a=summary) and found the right version for me [here](https://git.videolan.org/?p=ffmpeg/nv-codec-headers.git;a=commit;h=b641a195edbe3ac9788e681e22c2e2fad8aacddb).

Before the compiling `ffmpeg`, I installed the following development packages on my Debian Bullseye:

-   libchromaprint-dev
-   frei0-plugins-dev
-   flite1-dev
-   libgme-dev
-   libgsm1-dev
-   libjack-dev
-   libjack0
-   libmysofa-dev
-   librabbitmq-dev
-   librsvg2-dev
-   librubberband-dev
-   libshine-dev
-   libsnappy-dev
-   libspeex-dev
-   libomxil-bellagio-dev
-   libssh-dev
-   libtwolame-dev
-   libvidstab-dev
-   libxvidcore-dev
-   libzmq3-dev
-   libzvbi-dev
-   lv2-dev
-   libpocketsphinx-dev
-   libmfx-dev
-   libdc1394-dev
-   libdrm-dev
-   libiec61883-dev: N.B. after installing it, the configure script of `ffmpeg` still cannot find it.

Then I ran the old `ffmpeg` installed from Debian package, which displayed its configure options. Using these as template, I added CUDA related options, such as `--enable-cuds-nvcc`, `--enable-libnpp`. The complete configure options are given below.

```bash
./configure --libdir=/usr/lib/x86_64-linux-gnu --incdir=/usr/include/x86_64-linux-gnu --arch=amd64 --enable-cuda-nvcc --enable-libnpp --extra-cflags=-I/usr/local/cuda/include --extra-ldflags=-L/usr/local/cuda/lib64 --enable-libfdk-aac --enable-nonfree --enable-gpl --disable-stripping --enable-gnutls --enable-ladspa --enable-libaom --enable-libass --enable-libbluray --enable-libbs2b --enable-libcaca --enable-libcdio --enable-libcodec2 --enable-libdav1d --enable-libflite --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-libgme --enable-libgsm --enable-libjack --enable-libmp3lame --enable-libmysofa --enable-libopenjpeg --enable-libopenmpt --enable-libopus --enable-libpulse --enable-librabbitmq --enable-librsvg --enable-librubberband --enable-libshine --enable-libsnappy --enable-libsoxr --enable-libspeex --enable-libsrt --enable-libssh --enable-libtheora --enable-libtwolame --enable-libvidstab --enable-libvorbis --enable-libvpx --enable-libwebp --enable-libx265 --enable-libxml2 --enable-libxvid --enable-libzmq --enable-libzvbi --enable-lv2 --enable-omx --enable-openal --enable-opengl --enable-sdl2 --enable-pocketsphinx --enable-libmfx --enable-libdc1394 --enable-libdrm --enable-chromaprint --enable-frei0r --enable-libx264 --enable-shared
```

After compilation and installation, we can check available CUDA related codecs by running the command:

```bash
/usr/local/bin/ffmpeg -codecs | grep cuvid
```
