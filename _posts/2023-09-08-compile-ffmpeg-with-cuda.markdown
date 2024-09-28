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

    DEV.L. av1                  Alliance for Open Media AV1 (decoders: libdav1d libaom-av1 av1 av1_cuvid av1_qsv ) (encoders: libaom-av1 )
    DEV.LS h264                 H.264 / AVC / MPEG-4 AVC / MPEG-4 part 10 (decoders: h264 h264_v4l2m2m h264_qsv h264_cuvid ) (encoders: libx264 libx264rgb h264_nvenc h264_omx h264_qsv h264_v4l2m2m )
    DEV.L. hevc                 H.265 / HEVC (High Efficiency Video Coding) (decoders: hevc hevc_qsv hevc_v4l2m2m hevc_cuvid ) (encoders: libx265 hevc_nvenc hevc_qsv hevc_v4l2m2m )
    DEVIL. mjpeg                Motion JPEG (decoders: mjpeg mjpeg_cuvid mjpeg_qsv ) (encoders: mjpeg mjpeg_qsv )
    DEV.L. mpeg1video           MPEG-1 video (decoders: mpeg1video mpeg1_v4l2m2m mpeg1_cuvid )
    DEV.L. mpeg2video           MPEG-2 video (decoders: mpeg2video mpegvideo mpeg2_v4l2m2m mpeg2_qsv mpeg2_cuvid ) (encoders: mpeg2video mpeg2_qsv )
    DEV.L. mpeg4                MPEG-4 part 2 (decoders: mpeg4 mpeg4_v4l2m2m mpeg4_cuvid ) (encoders: mpeg4 libxvid mpeg4_omx mpeg4_v4l2m2m )
    D.V.L. vc1                  SMPTE VC-1 (decoders: vc1 vc1_qsv vc1_v4l2m2m vc1_cuvid )
    DEV.L. vp8                  On2 VP8 (decoders: vp8 vp8_v4l2m2m libvpx vp8_cuvid vp8_qsv ) (encoders: libvpx vp8_v4l2m2m )
    DEV.L. vp9                  Google VP9 (decoders: vp9 vp9_v4l2m2m libvpx-vp9 vp9_cuvid vp9_qsv ) (encoders: libvpx-vp9 vp9_qsv )

{{ 2023-09-08-compile-ffmpeg-with-cuda | backlink }}
