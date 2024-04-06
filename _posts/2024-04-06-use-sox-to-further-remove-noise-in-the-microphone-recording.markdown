---
layout: post
title: Use sox to further remove noise in the microphone recording
date: 2024-04-06
categories: [computer]
tags: [audio,multiple,PulseAudio]
mathjax: false
---

-   Install Debian package `sox`.
-   Load the kernel module `snd_aloop` to create an ALSA loopback device.
    
    ```text
    sudo modprobe snd_aloop
    ```
-   Record a noise and generate noise profile using `sox`.
    
    ```text
    sox noise-from-headset.wav -n noiseprof noise-from-headset.prof
    ```
-   Use `pacmd` to get the device name of the newly created loopback device for output, which should be `alsa_output.platform-snd_aloop.0.analog-stereo`.
    
    ```bash
    pactl list | grep -E -A2 '(Source|Sink) #' | grep 'Name: ' | grep -v monitor | cut -d" " -f2 | grep output.*aloop
    ```

-   Pipe the audio stream from the microphone through `sox`.
    
    ```text
    pacat -r -d echoCancel_source --latency=1msec | sox -v 0.8 -b 16 -c 2 -e signed -t raw -r 48000 - -C 0.5 -b 16 -c 2 -e signed -r 48000 -t raw - noisered /home/jihuan/文档/Documents/computer/linux/experiment/2024-04-03-reduce-noise-from-microphone/noise-from-headset.prof 0.21 | pacat -p -d alsa_output.platform-snd_aloop.0.analog-stereo --latency=1msec
    ```
-   Record in Audacity or some other tool using the loopback ALSA input source `alsa_input.platform-snd_aloop.0.analog-stereo`. This device name can be obtained by running this command:
    
    ```bash
    pactl list | grep -E -A2 '(Source|Sink) #' | grep 'Name: ' | grep -v monitor | cut -d" " -f2 | grep input.*aloop
    ```

N.B. `alsa_input.platform-snd_aloop.0.analog-stereo` is a virtual device in the loopback sound card, which is to be connected to a recording application. Meanwhile, `echoCancel_source` is the actual `PulseAudio` device to receive physical audio stream collected from the microphone. Therefore, the default source of `PulseAudio` should be set to `echoCancel_source`, but not `alsa_input.platform-snd_aloop.0.analog-stereo`.

References

-   <https://askubuntu.com/a/608211>
