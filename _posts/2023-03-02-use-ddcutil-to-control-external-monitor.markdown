---
layout: post
title: Use ddcutil to control external monitor
date: 2023-03-02
categories: [computer]
tags: [Linux,command]
mathjax: false
---

According to [Wikipedia](https://en.wikipedia.org/wiki/Display_Data_Channel), DDC/CI (Command Interface) standard was introduced in August 1998, which specifies a means for a computer to send commands to the monitor, as well as receive sensor data from the monitor, over a bidirectional link. My second external monitor is Dell P2222H, which just supports this functionality. Therefore, it is possible to adjust brightness and contrast from software without bothering to manipulate a button on the back.

On Linux, this can be achieved via `ddcutil`. To make it work with NVIDIA graphics card, we should copy `/usr/share/ddcutil/data/90-nvidia-i2c.conf` into the folder `/etc/X11/xorg.conf.d/` and modify the device name in this file to be the same as that is specified in `/etc/X11/xorg.conf` for `nvidia` driver (if `xorg.conf` exists). For example,

```text
Section "Device"
Driver "nvidia"
Identifier "Device0"
Option     "RegistryDwords"  "RMUseSwI2c=0x01; RMI2cSpeed=100"
# solves problem of i2c errors with nvidia driver
# per https://devtalk.nvidia.com/default/topic/572292/-solved-does-gddccontrol-work-for-anyone-here-nvidia-i2c-monitor-display-ddc/#4309293
EndSection
```

Then restart X11 or reboot the system, we can now control the monitor using `ddcutil` on the command line. Typical usage of `ddcutil`:

-   Detect connected monitors.
    
    ```text
    sudo ddcutil detect
    ```
    
    My computer reports
    
    ```text
    Display 1
    I2C bus:             /dev/i2c-1
    EDID synopsis:
    Mfg id:           BNQ
    Model:            BenQ PD2700U
    Serial number:    ETJCK80010CL0
    Manufacture year: 2019
    EDID version:     1.4
    VCP version:         2.2
    
    Display 2
    I2C bus:             /dev/i2c-2
    EDID synopsis:
    Mfg id:           DEL
    Model:            DELL P2222H
    Serial number:    H35TPK3
    Manufacture year: 2022
    EDID version:     1.4
    VCP version:         2.1
    ```
-   Get the capabilities supported by the monitor, for example, display 2 is my Dell monitor.
    
    ```text
    sudo ddcutil --display 2 capabilities
    
    Model: P2222H
    MCCS version: 2.1
    Commands:
    Command: 01 (VCP Request)
    Command: 02 (VCP Response)
    Command: 03 (VCP Set)
    Command: 07 (Timing Request)
    Command: 0c (Save Settings)
    Command: e3 (Capabilities Reply)
    Command: f3 (Capabilities Request)
    VCP Features:
    Feature: 02 (New control value)
    Feature: 04 (Restore factory defaults)
    Feature: 05 (Restore factory brightness/contrast defaults)
    Feature: 08 (Restore color defaults)
    Feature: 10 (Brightness)
    Feature: 12 (Contrast)
    Feature: 14 (Select color preset)
    Values:
    05: 6500 K
    08: 9300 K
    0b: User 1
    0c: User 2
    Feature: 16 (Video gain: Red)
    Feature: 18 (Video gain: Green)
    Feature: 1A (Video gain: Blue)
    Feature: 52 (Active control)
    Feature: 60 (Input Source)
    Values:
    01: VGA-1
    0f: DisplayPort-1
    11: HDMI-1
    Feature: AA (Screen Orientation)
    Values:
    01: 0 degrees
    02: 90 degrees
    04: 270 degrees
    Feature: AC (Horizontal frequency)
    Feature: AE (Vertical frequency)
    Feature: B2 (Flat panel sub-pixel layout)
    Feature: B6 (Display technology type)
    Feature: C6 (Application enable key)
    Feature: C8 (Display controller type)
    Feature: C9 (Display firmware level)
    Feature: CC (OSD Language)
    Values:
    02: English
    03: French
    04: German
    06: Japanese
    09: Russian
    0a: Spanish
    0d: Chinese (simplified / Kantai)
    0e: Portuguese (Brazil)
    Feature: D6 (Power mode)
    Values:
    01: DPM: On,  DPMS: Off
    04: DPM: Off, DPMS: Off
    05: Write only value to turn off display
    Feature: DC (Display Mode)
    Values:
    00: Standard/Default mode
    03: Movie
    05: Games
    Feature: DF (VCP Version)
    Feature: E0 (manufacturer specific feature)
    Feature: E1 (manufacturer specific feature)
    Feature: E2 (manufacturer specific feature)
    Values: 00 02 04 0E 12 14 (interpretation unavailable)
    Feature: F1 (manufacturer specific feature)
    Feature: F2 (manufacturer specific feature)
    Feature: FD (manufacturer specific feature)
    Feature: FE (manufacturer specific feature)
    ```
    
    From above, we can see the VCP feature code for brightness is 10 and that for contrast is 12.
-   Get all VCP parameter values.
    
    ```bash
    sudo ddcutil --display 2 getvcp all
    ```
    
    It returns the following information.
    
    ```text
    VCP code 0x02 (New control value             ): One or more new control values have been saved(0x02)
    VCP code 0x0b (Color temperature increment   ): Invalid value: 0
    VCP code 0x0c (Color temperature request     ): 3000 + 2 * (feature 0B color temp increment) degree(s) Kelvin
    VCP code 0x0e (Clock                         ): current value =    50, max value =   100
    VCP code 0x10 (Brightness                    ): current value =    40, max value =   100
    VCP code 0x12 (Contrast                      ): current value =    30, max value =   100
    VCP code 0x14 (Select color preset           ): User 2 (sl=0x0c)
    VCP code 0x16 (Video gain: Red               ): current value =   100, max value =   100
    VCP code 0x18 (Video gain: Green             ): current value =   100, max value =   100
    VCP code 0x1a (Video gain: Blue              ): current value =    85, max value =   100
    VCP code 0x1e (Auto setup                    ): Auto setup not active (sl=0x00)
    VCP code 0x20 (Horizontal Position (Phase)   ): current value =   249, max value =   100
    VCP code 0x30 (Vertical Position (Phase)     ): current value =    11, max value =   100
    VCP code 0x3e (Clock phase                   ): current value =     0, max value =   100
    VCP code 0x52 (Active control                ): Value: 0x14
    VCP code 0x60 (Input Source                  ): DisplayPort-1 (sl=0x0f)
    VCP code 0x62 (Audio speaker volume          ): current value =    15, max value =   255
    VCP code 0x6c (Video black level: Red        ): current value =   128, max value =   255
    VCP code 0x6e (Video black level: Green      ): current value =   128, max value =   255
    VCP code 0x70 (Video black level: Blue       ): current value =   128, max value =   255
    VCP code 0x8d (Audio Mute                    ): Invalid value (sl=0x00)
    VCP code 0xaa (Screen Orientation            ): 0 degrees (sl=0x01)
    VCP code 0xac (Horizontal frequency          ): 1964 hz
    VCP code 0xae (Vertical frequency            ): 60.00 hz
    VCP code 0xb2 (Flat panel sub-pixel layout   ): Red/Green/Blue vertical stripe (sl=0x01)
    VCP code 0xb4 (Source Timing Mode            ): mh=0x00, ml=0x02, sh=0x00, sl=0x01
    VCP code 0xb6 (Display technology type       ): LCD (active matrix) (sl=0x03)
    VCP code 0xc0 (Display usage time            ): Usage time (hours) = 123 (0x00007b) mh=0xff, ml=0xff, sh=0x00, sl=0x7b
    VCP code 0xc6 (Application enable key        ): 0x45cc
    VCP code 0xc8 (Display controller type       ): Mfg: Mstar (sl=0x05), controller number: mh=0x00, ml=0x00, sh=0x56
    VCP code 0xc9 (Display firmware level        ): 41.2
    VCP code 0xca (OSD                           ): OSD Enabled (sl=0x02)
    VCP code 0xcc (OSD Language                  ): English (sl=0x02)
    VCP code 0xd6 (Power mode                    ): DPM: On,  DPMS: Off (sl=0x01)
    VCP code 0xdc (Display Mode                  ): Standard/Default mode (sl=0x00)
    VCP code 0xde (Scratch Pad                   ): SL: 0x00 ,  SH: 0x00
    VCP code 0xdf (VCP Version                   ): 2.1
    ```

With the above command and information, I can create scripts for setting brightness and contrast for day and evening respectively.

```text
# For day
sudo ddcutil --display 2 setvcp 10 55
sudo ddcutil --display 2 setvcp 12 50
sudo ddcutil --display 2 setvcp 1a 85

# For evening
sudo ddcutil --display 2 setvcp 10 40
sudo ddcutil --display 2 setvcp 12 30
sudo ddcutil --display 2 setvcp 1a 75
```

{{ "2023-03-02-use-ddcutil-to-control-external-monitor" | backlink }}
