---
layout: post
title: Use GNU Linux in Virtualbox on Windows
date: 2025-05-03
categories: [computer]
tags: [Linux]
mathjax: false
---

**Use X11 instead of Wayland**

-   Input method: `fcitx5` can start in Wayland but not in X11, while `ibus` can start in X11.
-   Wacom tablet does not work in Wayland and only works in X11, because there is only the package `xserver-xorg-input-wacom`.
-   Bi-directional clipboard function provided by Virtualbox does not work in Wayland but only in X11.

**Some part of the desktop area is not clickable**

Solution: in display settings, use the VBoxVGA graphics controller instead of VMSVGA. Also disable 3D acceleration.

**Network**

-   Make the virtual network adaptor attached to NAT.
-   The network of the host machine as well as the host machine itself is visible to the virtual machine, hence the host machine can be directly accessed using the physical IP of the host machine.
    
    Therefore, VPN (shadowsocks) setup on the host can also be accessed from the virtual machine.
-   Access the virtual machine from the host using port mapping
    
    For example, we map SSH port 22 in the virtual machine to 127.0.0.1:2222 in the host. Then we can use `scp` to copy files from host to the virtual machine.
-   In the shared folder setting, we can also map the user folder on Windows to a directory in the virtual machine.

**Sound configuration in GNU/Linux**

-   Playback devices: 内置音频 模拟立体声
-   Device profiles: 模拟立体声 输出

**USB**

-   Add a new USB device filter with all fields set to empty strings, so that any external USB device can be matched.
-   When starting the virtual OS, do not connect the USB disk.

{{ "2025-05-03-use-gnu-linux-in-virtualbox-on-windows" | backlink }}
