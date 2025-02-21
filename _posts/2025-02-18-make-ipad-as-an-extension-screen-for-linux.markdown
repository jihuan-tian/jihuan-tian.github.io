---
layout: post
title: Make iPad as an extension screen for Linux
date: 2025-02-21
categories: [computer]
tags: [Linux,X-Window]
mathjax: false
---

**Solution**

Create a virtual screen beside the primary monitor. Then share it via `x11vnc` on display `:0` <sup><a id="fnr.1" class="footref" href="#fn.1" role="doc-backlink">1</a></sup>. Finally, access from iPad using the RealVNC viewer.

**Procedures**

1.  Check existing monitors.
    
    ```bash
    xrandr --listmonitors
    ```
    
        Monitors: 2
         0: +*DP-4 3840/597x2160/336+0+0  DP-4
         1: +DP-6 1080/476x1920/268+3840+0  DP-6
2.  Let the Linux system recognize the monitor DP-1, even though it is not physically connected, by adding the following two lines to the **Screen** section in `/etc/X11/xorg.conf`.
    
    ```text
    Section "Screen"
        Option         "ConnectedMonitor" "DP-4,DP-6,DP-1"
        Option         "ModeValidation" "NoDFPNativeResolutionCheck,NoVirtualSizeCheck,NoMaxPClkCheck,NoHorizSyncCheck,NoVertRefreshCheck,NoWidthAlignmentCheck"
    EndSection
    ```
3.  Restart the display manager `sudo systemctl restart lightdm.service`.
4.  Use `xrandr` to check the list of modes supported by DP-1 and select the maximum one that matches my iPad.
    
    Originally, I wanted to use the following command to generate a new mode, which matches the resolution of my iPad, and apply it to DP-1.
    
    ```bash
    cvt 2048 1536 60
    ```
    
        # 2048x1536 59.95 Hz (CVT 3.15M3) hsync: 95.45 kHz; pclk: 267.25 MHz
        Modeline "2048x1536_60.00"  267.25  2048 2208 2424 2800  1536 1539 1543 1592 -hsync +vsync
    
    ```text
    xrandr --newmode "2048x1536_60" 267.25  2048 2208 2424 2800  1536 1539 1543 1592 -hsync +vsync
    xrandr --addmode DP-1 2048x1536_60
    ```
    
    *However, the last command failed and it seems only existing modes of DP-1 can be used.*
5.  Make DP-1 on the left of the primary monitor. Both of them are on the default display `:0`.
    
    ```text
    xrandr --output DP-1 --mode 2048x1536_60 --left-of DP-4
    ```
6.  In KDE display settings, we can actually select the desired mode 2048x1536 for DP-1 with 60 Hz refresh rate, even though the previous command `xrandr --addmode DP-1 2048x1536_60` failed.
7.  Set a password for the VNC server.
    
    ```text
    x11vnc -storepasswd
    ```
8.  Start the VNC server `x11vnc`.
    
    ```text
    x11vnc -clip 2048x1536+0+0 -multiptr -nevershared -forever -nopw -rfbport 5901 -rfbauth ~/.vnc/passwd -display :0 &
    ```
    
    N.B. `-multiptr` is mandatory because I want to move the mouse cursor on Linux and view its motion on iPad.
9.  Remember to enable port 5901 in iptable rules.

## Footnotes

<sup><a id="fn.1" class="footnum" href="#fnr.1">1</a></sup> `x11vnc` is a VNC server to allow remote access to an existing X session. `tightvncserver` cannot be used, because it only supports creating a new X11 display, so that the virtual screen cannot be integrated the current desktop.

{{ "2025-02-18-make-ipad-as-an-extension-screen-for-linux" | backlink }}
