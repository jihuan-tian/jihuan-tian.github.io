---
layout: post
title: Adjust PDF file margin for printing
date: 2022-09-11
categories: [computer]
tags: [PDF]
mathjax: false
---

The following set of tools can cooperate to achieve the said purpose, which allows me to read papers with an appropriate font size.

1.  Get the screen resolution (unit is pixel per inch) by calling `xdpyinfo`:
    
    ```bash
    xdpyinfo | grep resolution
    ```
    
        resolution:    82x82 dots per inch

2.  Open the PDF file in Okular and set the zoom percentage to 100%.

3.  Use the screen measuring tool `kruler` to get the desired margin size in pixels.

4.  Convert the margin size from pixel to bp (i.e. big point, 1/72 inch).

5.  Call `pdfcrop` to modify the margin. On Debian, `pdfcrop` is included in the package `texlive-extra-utils`. The specified margin size has the unit bp and can be either positive or negative, which is with respect to the effective text area without margin.
    
    ```bash
    # Specify a single margin size for all page sides.
    pdfcrop --margins <all-sides> input.pdf output.pdf
    # Specify same left and right, top and bottom margin size values.
    pdfcrop --margins '<left/right> <top/bottom>' input
    # Specify margin size values for four page sides indpendently.
    pdfcrop --margins '<left> <top> <right> <bottom>' input.pdf output.pdf
    ```

{{ "2022-09-11-adjust-pdf-file-margin-for-printing" | backlink }}
