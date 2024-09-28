---
layout: post
title: Octave figure window tuning for high DPI monitor
date: 2022-10-17
categories: [computer]
tags: [Octave]
mathjax: false
---

Octave figure window and its font look extremely small when being displayed in a high DPI monitor.

<p align="center"><img src="/figures/2022-10-17_14-06-38-octave-small-figure-in-high-dpi.png" alt="" /></p>

Even though the Qt graphics toolkit, which is used by Octave GUI, supports automatic scaling (this can be enabled by setting the Boolean environment variable `QT_AUTO_SCREEN_SCALE_FACTOR` to 1), it will only enlarge the size of the figure window and its widgets but not the font size.

<p align="center"><img src="/figures/2022-10-17_14-08-26-octave-figure-window-qt-scale-in-high-dpi.png" alt="" /></p>

Therefore, the visual effect of an Octave figure window should be manually tuned for the high DPI monitor.

1.  Start Octave without Qt automatic screen scaling by creating a Bash alias:
    
    ```bash
    alias octave="QT_AUTO_SCREEN_SCALE_FACTOR=0 octave --silent"
    ```
2.  Increase the default font size and line width in `~/.octaverc`.
    
    ```octave
    set (0, "defaultaxesfontname", "Helvetica");
    set (0, "defaultaxesfontsize", 24);
    set (0, "defaulttextfontname", "Helvetica");
    set (0, "defaulttextfontsize", 24);
    set(0, "defaultlinelinewidth", 4);
    ```
3.  Define a function for creating a new figure with a doubled size.
    
    ```octave
    function CreateFig(h)
      if (exist("h", "var"))
        figure(h);
      else
        h = figure;
      endif
    
      current_pos = get(h, "position");
      ## Double the size of the figure window.
      current_pos(3:4) = current_pos(3:4) * 2;
      set(h, "position", current_pos);
    endfunction
    ```

Now the enlarged figure window is shown below.

<p align="center"><img src="/figures/2022-10-17_14-20-28-octave-figure-window-enlarged-in-high-dpi.png" alt="" /></p>

{{ 2022-10-17-octave-figure-window-tuning-for-high-dpi-monitor | backlink }}
