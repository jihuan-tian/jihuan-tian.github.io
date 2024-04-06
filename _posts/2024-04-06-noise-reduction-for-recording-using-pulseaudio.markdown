---
layout: post
title: Noise reduction for recording using PulseAudio
date: 2024-04-06
categories: [computer]
tags: [audio,multimedia,PulseAudio]
mathjax: false
---

When I perform sound recording using the microphone on my Logitech H151 headset as well as the default HDA Intel PCH sound card on my PC, there is too much noise. Then I use the following steps to reduce the noise level.

-   Check if `module-echo-cancel` is loaded by `PulseAudio`. Usually, it is not enabled by default. Therefore, the following command will return nothing.
    
    ```bash
    pacmd list-modules | grep module-echo-cancel
    ```
-   At the moment, there are two audio input devices on my PC. Besides the input of the said sound card HDA Intel PCH, the other is the microphone in my Logitech C930C webcam. Therefore, I need to know the ALSA device name of HDA Intel PCH&rsquo;s input by executing this command:
    
    ```bash
    pacmd list-sources  | grep name: | grep input
    ```

-   Add the following lines in `/etc/pulseaudio/default.pa` to enable echo and noise cancellation for HDA Intel PCH.
    
    ```text
    ## When analog_gain_control=1, there will be distortion. Therefore, set it to 0.
    ## When digital_gain_control=1, automatic gain control is done in post processing by CPU.
    .ifexists module-echo-cancel.so
    load-module module-echo-cancel source_master=alsa_input.pci-0000_00_1b.0.analog-stereo aec_method=webrtc aec_args="analog_gain_control=0 digital_gain_control=1" source_name=echoCancel_source sink_name=echoCancel_sink
    .endif
    
    ### Make some devices default
    ## set-default-sink echoCancel_sink
    set-default-source echoCancel_source
    ```
    
    N.B.
    
    1.  In `PulseAudio`, a `source` is a device that can emit digital audio stream to `PulseAudio`, e.g. microphone, line input, or some entity which is not a physical audio device but can still generate the audio stream. On the other hand, a `sink` is a device that can output digital audio stream from `PulseAudio`, such as speaker signal, headphone output, etc. Still, a `sink` may not be a physical audio device.
    2.  `source_master` in the above configuration specifies the sound `source`, which is the ALSA input device in the HDA Intel PCH sound card.
    3.  `source_name` in the above configuration is the `PulseAudio` device name. The audio stream from this device will be filtered to a small noise level.

-   Restart `PulseAudio` server
    
    ```bash
    pulseaudio -k
    pulseaudio --start
    ```

-   References
    -   <https://wiki.archlinux.org/title/PulseAudio>
    -   <https://www.linuxuprising.com/2020/09/how-to-enable-echo-noise-cancellation.html>
    -   About beamforming
        -   <https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Modules/#index45h3>
        -   <https://arunraghavan.net/2016/06/beamforming-in-pulseaudio/>
