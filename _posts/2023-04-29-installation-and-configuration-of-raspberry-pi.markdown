---
layout: post
title: Installation and configuration of Raspberry Pi
date: 2023-04-29
categories: [computer]
tags: [Raspberry-Pi]
mathjax: false
---

Recently, I&rsquo;ve bought a Raspberry Pi 4b with 4GB RAM for setting up
my family network drive. It is expected to free the space of my old
laptop&rsquo;s Windows C drive and share multimedia files over the local
network. The procedures are summarized below as a memorandum.

# System installation

-   Download the Raspbian operating system image into the SD card using [Raspberry Pi Imager](https://www.raspberrypi.com/software/).
-   Use [Tsinghua](https://mirrors.tuna.tsinghua.edu.cn/help/raspbian/) source list:
    
        # /etc/apt/sources.list
        deb http://mirrors.tuna.tsinghua.edu.cn/raspbian/raspbian/ bullseye main non-free contrib rpi
        # deb-src http://mirrors.tuna.tsinghua.edu.cn/raspbian/raspbian/ bullseye main non-free contrib rpi
        
        # /etc/apt/sources.list.d/raspi.list
        deb http://mirrors.tuna.tsinghua.edu.cn/raspberrypi/ bullseye main ui


Install the following packages

-   samba: for sharing file over local network
-   cifs-utils (installed by default): for mounting NTFS disk partition
-   git: for software backup
-   rsync (installed by default): for file synchronization and backup
-   gdisk (installed by default): for creating GUID partition, which is needed when the disk space is larger than 2 TB.
-   cryptsetup: for encrypting disks using LUKS
-   veracrypt: for disk encryption, which can be downloaded from the [official site](https://www.veracrypt.fr/en/Downloads.html). For Raspberry Pi, select the `armhf` hardward architecture. This information can be acquired by executing `dpkg --print-architectures`.
    
    Before insllation, its dependency `libfuse2` should be installed from the source list.


# Configurations

## Display Chinese characters

1.  Reconfigure `locales` and generate the `zh_CN.UTF-8` locale.
    
        sudo dpkg-reconfigure locales
2.  After configuration, the Chinese characters still cannot be displayed. We should further execute
    
        export LC_ALL=zh_CN.UTF-8


## Start the system into console without auto login

Execute `sudo raspi-config` and select `System options` → `S5 Boot / Auto Login` → `B1 Console`.


## Configure iptables for firewall control

Create iptable rules a file, such as `/etc/iptable_rules`. Then add the following line to `/etc/network/if-pre-up.d/iptables`, so that the rules will be loaded after the system start.

    sudo iptables-restore < /etc/iptable_rules


## Automount NTFS hard disk

Edit `/etc/fstab` as below.

    /dev/sda2  /media/documents ntfs-3g auto,rw,suid,exec,async,nouser,uid=1000,gid=1000,umask=002,locale=zh_CN.UTF-8 0 0

In the above configuration, settting the correct user ID, group ID and locale are important.


## Configure Samba server

1.  Add the Linux system user `<user name>` as client for accessing Samba and set its password.
    
        sudo smbpasswd -a <user name>
2.  Edit `/etc/samba/smb.conf` to add folders to be shared and configure their access rights.
3.  Reload the configuration `smb.conf`
    
        sudo smbcontrol smbd reload-config


# Issues solved

-   Because my old hard disk to be mounted to Raspberry Pi does not supported USB3, inserting it to the USB3 port of Raspberry Pi will make the system halt. Therefore, do remember to connect the old disk to USB2 port.
-   When editing `/etc/fstab` for automounting the hard disk, I initially specifed UUID instead of the device name `/dev/sda2`. This made Raspberry Pi fail to boot with the message:
    
        Cannot open access to console, the root account is locked.
    
    This problem can be solved as below.
    
    1.  Unplug the SD card and insert it into a PC.
    2.  Mount the `boot` partition and append the text `init=/bin/sh` to the file `cmdline.txt`.
    3.  Reboot Raspberry Pi and get access to the console. Modify `/etc/fstab` and restore the original contents of the file `/boot/cmdline.txt`.

{{ "2023-04-29-installation-and-configuration-of-raspberry-pi" | backlink }}
