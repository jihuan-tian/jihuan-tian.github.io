---
layout: post
title: Listening to English audio with lyrics on Linux
date: 2022-04-16
categories: [computer]
tags: [英语学习,Linux,multimedia,ffmpeg]
mathjax: false
---

To study English from movies is consistent with the methodology of praxis. GNU/Linux provides us a bunch of tools to extract audio and subtitle from videos as well as play the music file with scrolling lyrics. Using this study mode, we can focus on the English pronunciation, vocabulary and wording adopted in the script.

# Generate lyrics from subtitle

1. Extract the audio from a video using `ffmpeg`, for example
	
	```bash
	ffmpeg -i movie-file-name -vn -ar 44100 -ac 2 -b:a 192k -f mp3 movie-audio.mp3
	```

   Here, `-i` specifies the input video file name, `-vn` disables the video, `-ar` specifies the audio sampling frequency in Hz, `-ac` specifies the number of audio channels, `-b:a` sets the audio bitrate in kbit/s and `-f` specifies the file format.
	
2. Extract the embedded subtitle from `mkv`

   Install `mkvtoolnix` and `mkvtoolnix-gui` using `apt-get`. After opening a `mkv` file in `mkvtoolnix-gui`, select the English subtitle only and export it as a `mks` file. If the subtitle is an independent file, this step can be skipped.

   ![mkvtoolnix-gui](/figures/Screenshot_20220416_mkvtoolnix.png)
	
3. Convert the subtitle file to lyrics using `ffmpeg`

	```bash
	ffmpeg -i subtitle-file-name subtitle.lrc
	```

# Compile and install the tool for displaying lyrics

1. Clone `osdlyrics` from GitHub

	```bash
	git clone https://github.com/osdlyrics/osdlyrics.git
	```

2. Install the following dependencies using `apt-get`
   * `intltool`
   * `libdbus-glib-1-dev` and `libdbus-glib-1-dev-bin`
   * `python3-future` and `python3-pycurl`

3. Enter the cloned directory, compile and install `osdlyrics`.

    ```bash
	./autogen.sh
	./configure PYTHON=/usr/bin/python3
	make -j4
	sudo make install
	```
	
    However, after the installation, `osdlyrics` cannot be started reporting the following message, which indicates the errors is caused by `osdlyrics-daemon`.
	
	> *Error*: in function _start_daemon_cb: ol_main.c[769]
	> Unable to start daemon: GDBus.Error:org.freedesktop.DBus.Error.Spawn.ChildExited: Process org.osdlyrics.Daemon exited with status 1

    By manually running `osdlyrics-daemon`, we can see that the Python module `osdlyrics` cannot be found, even though it has been installed to `/usr/local/lib/python3.7/site-packages`. This is because the default path for searching packages by Python 3.7 should be `/usr/local/lib/python3.7/dist-packages` instead of `...site-packages`. Hence, creating a symbolic link under this path which points to `/usr/local/lib/python3.7/site-packages/osdlyrics` solves the problem.
	
    > Traceback (most recent call last):
    >   File "/usr/local/lib/osdlyrics/daemon/main.py", line 27, in <module>
    >     from osdlyrics import PACKAGE_VERSION
    > ModuleNotFoundError: No module named 'osdlyrics'

4. Run `osdlyrics` from the command line and select `VLC` as the associated music player. Even though my favorite music player `Audacious` is claimed to be supported, it actually does not work properly with `osdlyrics` at the moment. The command used by `osdlyrics` to start `VLC` is

	```
	/usr/bin/vlc --started-from-file %U
	```

Now the English movie audio can be played with a synchronously scrolling lyrics and a snapshot is given below. N.B. We can use `VLC`'s `A-B` mode to repeatedly listen to a fragment, which is very helpful for us to imitate the original pronunciation.

<p align="center"><img src="/figures/Screenshot_20220415_vlc-osdlyrics.png" alt="Scrolling lyrics" /></p>
<p align="center">Scrolling lyrics</p>
