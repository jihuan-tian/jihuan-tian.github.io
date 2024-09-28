---
layout: post
title: Control figure size and text size in GNU Octave
date: 2023-09-02
categories: [computer]
tags: [Octave]
mathjax: false
---

The following graphics object properties should be clarified.

-   Properties of the figure displayed on the screen
    -   `position` specifies the position and size in unit of pixel for the figure window&rsquo;s effective plot area, which is shown below. The default values are `[300 200 560 420]`.
        
        ![img](/figures/2023-09-01_18-25-06-octave-figure-position@octave.png)
-   Properties of the figure to be printed
    -   `paperposition` in unit of inch. The default values `[2.5131 4.2035 3.4739 2.5930]` are determined from the figure&rsquo;s default display size `[300 200 560 420]` using the monitor&rsquo;s actual DPI, which can be acquired by `get(0, 'screenpixelsperinch')`.
        
        -   For paged formats (such as PS, PDF, EPS, etc.), it specifies the position and size of the printed figure on the page.
        -   For non-paged formats (such as JPG, PNG, BMP, etc.), only `paperposition(3)` and `paperposition(4)` have effect.

-   Properties of the paper onto which the figure is to be printed, which is only applicable to paged formats
    
    -   `papersize` specifies the size with the unit specified by `paperunits` (the default unit is inch) of the paper onto which the figure will be printed. The default paper size is `8.5*11` inches, which is the US letter page.
    -   `paperorientation` specifies the orientation of the paper. The default orientation is portrait, which is consistent with the paper size `8.5*11` inches.
    
    Usually, there is no need to manually set the paper size, because it can be automatically deduced from the displayed figure size by the `print` function. This can be confirmed by checking the generated `*.tex` file below, if the `epslatexstandalone` engine is adopted:
    
    ```latex
    \usepackage[papersize={250.00bp,186.00bp},text={250.00bp,186.00bp}]{geometry}
    ```
    
    When the figure&rsquo;s display size changes, the above values `papersize` and `text` will change accordingly. These values have the unit bp, i.e. big point, which is 1/72 inch. `250 bp*186 bp` are computed from the figure&rsquo;s display size in unit of pixel, which are stored in `position(3)` and `position(4)`. The transformation shown below is based on the monitor&rsquo;s DPI detected by Octave.
    
    ```octave
    dpi = get(0, 'screenpixelsperinch')
    pointsize_inch = 1/72
    figure;
    position = get(gcf, 'position');
    floor(position(3:4) / dpi / pointsize_inch)
    ```
    
        dpi = 161.20
        pointsize_inch = 0.013889
        octave> octave> ans =
        
           250   187
-   Line width, marker size, etc. have the unit of point.

Any font size specified for the figure axe or other object such as legend and text has the `point` unit for both the displayed figure and the paged format figure. However, by a direct measurement of the text height on the screen, the displayed font size on the screen actually has the **pixel** unit. When the figure is printed, this font size value will be treated directly as **point**. This explains why the text looks much smaller in a figure window than its printed version. When there are lots of text to be displayed, even though everything looks fine in the displayed figure, in the printed figure, the font size seems too large and the characters clump together. This is because the figure size is not large enough, while the font size is always the specified value in point unit. To enlarge the printed size, modify the `paperposition` property.

![img](/figures/2023-09-01-clumped-text-in-octave-figure.png)

Options of the `print` function which overrides some figure properties:

-   `-S<XSIZE>,<YSIZE>` specifies the plot size in pixels for raster formats including PNG, JPEG, PNG, and unusually SVG. For all vector formats, the plot size is specified in points. N.B. this option must be wrapped by double quote to prevent Octave recognizing the comma. This option overwrites `paperposition(3)` and `paperposition(4)`. This option is useful when the characters in the figure clump together and we need a larger printed figure size.
    
    -   size in pixels for raster formats such as png, jpg, etc.
    -   size in points for vector formats such as pdf, eps, etc.
    
    **If this option is used, the font size in the generated LaTeX file will be totally incorrect.**
-   `-F:<SIZE>` specifies font size for all text in the figure. Not recommended.

When measuring figure size on the screen, I&rsquo;ve also found only `gv` can correctly display the actual (physical) size of an EPS image. Neither Okular nor Gwenview can. For viewing PNG files, Gwenview, Gimp and Okular will display the 100% scale by using the monitor&rsquo;s DPI such as 161, without considering the actual ppi used by the PNG file. Usually, I print a PNG file with a high resolution, such as 500. Therefore, the image viewed with 100% scale looks more than 3 (500dpi/161dpi) times larger than its physical size.

{{ "2023-09-02-control-figure-size-and-text-size-in-gnu-octave" | backlink }}
