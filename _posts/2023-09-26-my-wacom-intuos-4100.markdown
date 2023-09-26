---
layout: post
title: My Wacom Intuos 4100
date: 2023-09-26
categories: [computer]
tags: [Wacom,GoodNotes,iPad]
mathjax: false
---

Upgrading to GoodNotes version 6 needs an additional payment, even though I&rsquo;ve already purchased version 5. Therefore, the once claimed permanent software license is only valid for a single version, not the whole software life time. Meanwhile, CamScanner Pro for scanning documents which I purchased years ago cannot run on recent iPad OS anymore.

Considering building up a digital knowledge and information database which can last in a stable format at least for my whole life time, I find it mandatory to discard these seemingly well commercially supported and user friendly software tools and platform. Instead, I will switch to more fundamental and general hardware and software. For writing with a pen directly on a digital device, I&rsquo;ve abandoned iPad + Apple Pencil and started to use Wacom tablet. The following photo shows my Wacom Intuos 4100 tablet that was purchased on <span class="timestamp-wrapper"><span class="timestamp">&lt;2023-09-17 Sun&gt;</span></span>.

![img](/figures/2023-09-18-wacom-intuos-4000.JPG)

To make it supported by Debian Linux, the following packages should be installed:

-   `libwacom2`: driver for identifying Wacom tablets
-   `xserver-xorg-input-wacom`: X.Org driver for Wacom tablets

Then plug in the USB cable and the tablet just works without any problem.

We can use the `xsetwacom` command to check device information and customize tablet parameters. For example,

-   Show all devices
    
    ```bash
    xsetwacom list devices
    ```
    
    It shows four devices:
    
    -   Wacom Intuos S Pad pad id: 20 type: PAD: The pad tool is the physical tablet itself excluding the drawing area, including the buttons and the scroll ring or scroll strips (if applicable).
    -   Wacom Intuos S Pen stylus id: 21 type: STYLUS
    -   Wacom Intuos S Pen eraser id: 22 type: ERASER: not available on Intuos 4100
    -   Wacom Intuos S Pen cursor id: 23 type: CURSOR: not available on Intuos 4100
-   Show device parameters. N.B. Each time the Wacom tablet is connected to the computer, the device id may change. Therefore, using the device&rsquo;s full name is a better choice.
    
    ```bash
    xsetwacom get <device-id/device-full-name> all
    ```
    
    -   Default stylus device parameters
        
        ```text
        Option "Area" "0 0 15200 9500"
        Button: Actions are not supported by xorg.conf. Try shell format (-s) instead.
        Button: Actions are not supported by xorg.conf. Try shell format (-s) instead.
        Button: Actions are not supported by xorg.conf. Try shell format (-s) instead.
        Button: Actions are not supported by xorg.conf. Try shell format (-s) instead.
        Button: Actions are not supported by xorg.conf. Try shell format (-s) instead.
        Option "DebugLevel" "0"
        Option "CommonDBG" "0"
        Option "Suppress" "2"
        Option "RawSample" "4"
        Option "PressCurve" "0 0 100 100"
        Option "Mode" "Absolute"
        Option "TPCButton" "off"
        Option "Touch" "off"
        Property 'Wacom Hardware Touch Switch' does not exist on device.
        Option "Gesture" "off"
        Option "ZoomDistance" "0"
        Option "ScrollDistance" "0"
        Option "TapTime" "250"
        Property 'Wacom Proximity Threshold' does not exist on device.
        Option "Rotate" "none"
        Property 'Wacom Wheel Buttons' does not exist on device.
        Property 'Wacom Wheel Buttons' does not exist on device.
        Property 'Wacom Wheel Buttons' does not exist on device.
        Property 'Wacom Wheel Buttons' does not exist on device.
        Property 'Wacom Wheel Buttons' does not exist on device.
        Property 'Wacom Wheel Buttons' does not exist on device.
        Property 'Wacom Strip Buttons' does not exist on device.
        Property 'Wacom Strip Buttons' does not exist on device.
        Property 'Wacom Strip Buttons' does not exist on device.
        Property 'Wacom Strip Buttons' does not exist on device.
        Option "Threshold" "26"
        Option "Serial" "0"
        Option "PressureRecalibration" "on"
        ```
        
        It can be seen that in the above information, configuration for the buttons is not shown, which should be checked by adding the `-s` option as suggested. Then we have the following
        
        ```text
        xsetwacom set "21" "Button" "1" "button +1 "
        xsetwacom set "21" "Button" "2" "button +2 "
        xsetwacom set "21" "Button" "3" "button +3 "
        xsetwacom set "21" "Button" "8" "button +8 "
        xsetwacom set "21" "Button" "9" "button +9 "
        ```
    -   Map the tablet to an area on the screen:
        
        ```bash
        xsetwacom set <device-id/device-full-name> MapToOutput 3840x2160+0+0
        ```
    -   Adjust the effective input area on the tablet, which should have the same aspect ratio as the mapped screen area. The meaning of the `Area` parameter:
        
        > Area x1 y1 x2 y2 Set the tablet input area in device coordinates in the form top left x/y and bottom right x/y. Top left and bottom right are defined in the device&rsquo;s native orientation, regardless of the actual rotation currently applied. Input outside of these coordinates will be clipped to the edges of the area defined. Default: 0 0 x2 y2; with x2 and y2 tablet specific.
        
        As seen from above device parameters, the top left corner position and dimension of the original maximum input area is &ldquo;0 0 15200 9500&rdquo;. The resolution of the Wacom Intuos 4100 is 2540 dpi, hence the physical dimension of the input area is 152\*95 mm. The aspect ratio of my screen is 1.7778 and that of the Wacom tablet is 1.6, which is a little narrower. Therefore, use the width of the effective input area as the basis to derive the height of the input area using the aspect ratio of the screen.
        
        Compute the height of the input area:
        
        ```octave
        ans = 15200/(3840/2160);
        ```
        
            8550
        
        Use the command below to set the input area for the stylus.
        
        ```bash
        xsetwacom set <device-full-name> Area 0 0 15200 8550
        ```

I&rsquo;ve defined collections of `xsetwacom` commands for different applications that I often use.

-   Default configuration
    
    ```bash
    # Set effective input area on the tablet.
    xsetwacom set 'Wacom Intuos S Pen stylus' Area 0 0 15200 8550
    # Map the tablet's effective input area to the physical screen.
    xsetwacom set 'Wacom Intuos S Pen stylus' MapToOutput 3840x2160+0+0
    
    # Set default buttons on the pen stylus.
    xsetwacom set 'Wacom Intuos S Pen stylus' Button 1 "button +1"
    xsetwacom set 'Wacom Intuos S Pen stylus' Button 2 "button +2"
    xsetwacom set 'Wacom Intuos S Pen stylus' Button 3 "button +3"
    xsetwacom set 'Wacom Intuos S Pen stylus' Button 8 "button +8"
    xsetwacom set 'Wacom Intuos S Pen stylus' Button 9 "button +9"
    
    # Set default buttons on the pad.
    xsetwacom set 'Wacom Intuos S Pad pad' Button 1 "button +1"
    xsetwacom set 'Wacom Intuos S Pad pad' Button 2 "button +2"
    xsetwacom set 'Wacom Intuos S Pad pad' Button 3 "button +3"
    xsetwacom set 'Wacom Intuos S Pad pad' Button 8 "button +8"
    ```
-   Configuration for Xournal++, which is used for taking notes.
    
    ```bash
    # Draw line
    xsetwacom set 'Wacom Intuos S Pad pad' Button 1 "key +control 6 -control"
    # Draw rectangle
    xsetwacom set 'Wacom Intuos S Pad pad' Button 2 "key +control 2 -control"
    # Draw ellipse
    xsetwacom set 'Wacom Intuos S Pad pad' Button 3 "key +control 3 -control"
    # Draw arrow
    xsetwacom set 'Wacom Intuos S Pad pad' Button 8 "key +control 4 -control"
    
    # Set default buttons on the pen stylus.
    xsetwacom set 'Wacom Intuos S Pen stylus' Button 1 "button +1"
    xsetwacom set 'Wacom Intuos S Pen stylus' Button 2 "button +2"
    xsetwacom set 'Wacom Intuos S Pen stylus' Button 3 "button +3"
    xsetwacom set 'Wacom Intuos S Pen stylus' Button 8 "button +8"
    xsetwacom set 'Wacom Intuos S Pen stylus' Button 9 "button +9"
    ```
-   Configuration for Okular in presentation mode, with which I can mark my Beamer slides. In the definition of key combinations that are bound to Wacom tablet buttons, `+control` means pressing down the Ctrl key, while `-control` means release it. N.B. These key combinations should firstly be associated with related actions in Okular, then we can use Wacom tablet to trigger them.
    
    ```bash
    # Red pen
    xsetwacom set 'Wacom Intuos S Pad pad' Button 1 "key +control +shift 1 -shift -control"
    # Blue pen
    xsetwacom set 'Wacom Intuos S Pad pad' Button 2 "key +control +shift 2 -shift -control"
    # Yellow pen
    xsetwacom set 'Wacom Intuos S Pad pad' Button 3 "key +control +shift 5 -shift -control"
    # Erase all drawing on the screen
    xsetwacom set 'Wacom Intuos S Pad pad' Button 8 "key +control +shift 8 -shift -control"
    # Eraser
    xsetwacom set 'Wacom Intuos S Pen stylus' Button 2 "key +control +shift 7 -shift -control"
    
    # Set other default bindings in case they are modified elsewhere.
    xsetwacom set 'Wacom Intuos S Pen stylus' Button 1 "button +1"
    xsetwacom set 'Wacom Intuos S Pen stylus' Button 3 "button +3"
    xsetwacom set 'Wacom Intuos S Pen stylus' Button 8 "button +8"
    xsetwacom set 'Wacom Intuos S Pen stylus' Button 9 "button +9"
    ```
-   Configuration for Okular in reading and annotation mode, with which I can take notes directly in PDF files.
    
    ```bash
    # Highlighter
    xsetwacom set 'Wacom Intuos S Pad pad' Button 1 "key +alt 1 -alt"
    # Freehand line
    xsetwacom set 'Wacom Intuos S Pad pad' Button 2 "key +alt 8 -alt"
    # Stright line
    xsetwacom set 'Wacom Intuos S Pad pad' Button 3 "key +control +shift 9 -shift -control"
    # Rectangle
    xsetwacom set 'Wacom Intuos S Pad pad' Button 8 "key +alt 0 -alt"
    # Ellipse
    xsetwacom set 'Wacom Intuos S Pen stylus' Button 2 "key +control +shift 0 -shift -control"
    
    # Set other default bindings in case they are modified elsewhere.
    xsetwacom set 'Wacom Intuos S Pen stylus' Button 1 "button +1"
    xsetwacom set 'Wacom Intuos S Pen stylus' Button 3 "button +3"
    xsetwacom set 'Wacom Intuos S Pen stylus' Button 8 "button +8"
    xsetwacom set 'Wacom Intuos S Pen stylus' Button 9 "button +9"
    ```
