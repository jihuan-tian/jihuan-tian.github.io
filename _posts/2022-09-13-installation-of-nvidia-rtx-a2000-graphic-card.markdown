---
layout: post
title: Installation of NVIDIA RTX A2000 graphic card and configuration for HiDPI
date: 2022-09-13
categories: [computer]
tags: [hardware,NVIDIA,HiDPI]
mathjax: false
---

Yesterday, I installed a new NVIDIA RTX A2000 graphic card onto my personal PC. It replaces my old Geforce GT210 card which has been used for over 11 years. The procedures for compiling the official NVIDIA driver and post-tuning the display effect on my high DPI monitor are summarized below.

-   Download the driver `NVIDIA-Linux-x86_64-515.65.01.run` from NVIDIA&rsquo;s official website.
-   Install prerequisites for compiling the driver.
    
    ```bash
    apt-get install linux-headers-$(uname -r) build-essential libglvnd-dev pkg-config
    ```
-   Disable the default `nouveau` driver.
    
    ```bash
    echo blacklist nouveau > /etc/modprobe.d/blacklist-nvidia-nouveau.conf
    ```
-   Compile and install the driver, during which DKMS should be enabled.
    
    ```bash
    bash NVIDIA-Linux-x86_64-515.65.01.run
    ```

It is lucky that the installation was quick and successful, while I have never been successful with my old card following the same procedure.

Next, I adjusted the font size for displaying on my high DPI monitor, since everything looked extremely small after the new card started running.

-   KDE system font size configuration
-   Configure GTK3 font size in &ldquo;Application Style&rdquo;
-   Eclipse
    -   Enlarge all font size in the preferences
    -   Enlarge icon size by adding the following in the configuration file `eclipse.ini`:
        
        ```text
        -Dswt.enable.autoScale=true
        -Dswt.autoScale=200
        -Dswt.autoScale.method=nearest
        ```
-   Firefox: in `about:config`, set `layout.css.devPixelsPerPx` to 2.

-   Zotero: in `about:config`, set `layout.css.devPixelsPerPx` to 1.2.
-   Paraview
    
    ```bash
    export QT_AUTO_SCREEN_SCALE_FACTOR=1
    paraview &
    ```
    
    <span class="timestamp-wrapper"><span class="timestamp">[2023-09-01 Fri] </span></span> This variable should be set to 0 when using other programs, such as emacs and octave.
-   Anki: [Anki reference](https://docs.ankiweb.net/platform/windows/text-size.html) and [Qt reference](https://doc.qt.io/qt-5/highdpi.html)
    
    ```bash
    alias anki="ANKI_NOHIGHDPI=1 ANKI_WEBSCALE=1.5 anki"
    ```
-   Applications based on Java, such as PlantUML, yEd: set the environment variable `GDK_SCALE` to a value larger than 1. For example, in `~/.bashrc`:
    
    ```bash
    alias plantuml="GDK_SCALE=2 java -jar /usr/share/plantuml/plantuml.jar -gui -tsvg"
    ```
-   Netease music: add the command line option `--force-device-scale-factor=1.5`.

Finally, I enabled `vdpau` for playing video in VLC. This can be configured by setting VLC&rsquo;s video output device to `VDPAU output`.

See [here](https://wiki.archlinux.org/title/HiDPI) for more information about HiDPI configuration on Linux.
