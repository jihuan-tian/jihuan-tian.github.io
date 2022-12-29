---
layout: post
title: Notes for upgrading Debian from Buster to Bullseye
date: 2022-12-20
categories: [computer]
tags: [Linux,Debian]
mathjax: false
---

-   Use Tsinghua mirror (speed 11 MB/s) instead of previously used 163 mirror (speed 150 KB/s)
    
    ```text
    deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye main contrib non-free
    # deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye main contrib non-free
    deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-updates main contrib non-free
    # deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-updates main contrib non-free
    
    deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-backports main contrib non-free
    # deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-backports main contrib non-free
    
    deb https://mirrors.tuna.tsinghua.edu.cn/debian-security bullseye-security main contrib non-free
    # deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security bullseye-security main contrib non-free
    ```
-   During the upgrade, the following command needs to be executed (maybe several times) if needed.
    
    ```text
    apt --fix-broken install
    ```
-   After dist-upgrade, some issues should be handled as below, some of which still cannot be solved.
    -   [X] `/dev/sda` and `/dev/sdb` have been swapped after a warm system restart. Then the script `mount_disks.sh` for mounting hard disks should be modified. However, after performing a cold system restart, the order of hard disks returns to normal.
    -   [X] Desktop notes plasmoid cannot be displayed. Solution: install the `plasma-widgets-addons` package.
    -   [X] Because some packages have been uninstalled during the system upgrade, they should be reinstalled again, such as those common KDE packages, `kde-baseapps`, `plasma-widgets-addons`, `kde-plasma-desktop` and `kde-standard`.
    -   Emacs
        -   [ ] Toolbar icons are lost with only their texts left. Reconfiguring the GNOME/GTK application style in KDE settings only temporarily make the icons reappear but they do not persist after system restart. N.B. The configuration of GTK theme and associated icon theme is in the file `~/.config/gtk-3.0/settings.ini`.
            
            ```text
            gtk-theme-name=Breeze
            gtk-icon-theme-name=breeze
            gtk-fallback-icon-theme=breeze
            ```
        -   [ ] Files cannot be copied within Dired mode.
        -   [X] Org structure template is now triggered by `C-c C-,` instead of the old `<KEY`.
    -   [X] Font scaling for high DPI monitor in Plasma has been improved. There is no need to manually increase the font size anymore, only a universal scaling operation is enough. Hence, previously manually enlarged fonts in some applications such as Eclipse should be restored to normal. For example, adjust the font size from 18 pt to 12 pt. However, the toolbar icon size in Eclipse should still be manually scaled to 200% by adding the following configuration to the initialization file `eclipse.ini`.
        
        ```text
        -Dswt.enable.autoScale=true
        -Dswt.autoScale=200
        -Dswt.autoScale.method=nearest
        ```
    -   The rendering backend of the compositor should not use OpenGL, which will make the process `kwin_x11` occupy 100% CPU and the whole system stuck.
