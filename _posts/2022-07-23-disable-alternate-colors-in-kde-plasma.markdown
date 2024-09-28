---
layout: post
title: Disable alternate colors in KDE Plasma
date: 2022-07-23
categories: [computer]
tags: [KDE]
mathjax: false
---

I&rsquo;ve been using the [Solarized Deviant](https://store.kde.org/p/1527166/) color scheme in KDE Plasma, which looks mild and comfortable. It also applies alternate colors to the file list in Dolphin and the table of contents in the navigation panel of Okular. However, this destroys the consistency and uniformity of the aesthetic.

![img](/figures/2022-07-23_09-49-48-alternate-color-in-dolphin.png "Alternate colors in Dolphin")

The said alternate color effect can be disabled by going to the system configuration `Appearance` → `Colors` then editing the color scheme. In the `Colors` tab of the opened dialog, select `View` from the `Color set` list, then make the `Alternate Background` same as the `Normal Background`.

![img](/figures/2022-07-23_09-45-19-same-alternate-background.png "Change the alternate background color")

In the `Options` tab, disable `Apply effects to inactive windows`.

![img](/figures/2022-07-23_09-43-27-color-scheme-disable-inactive-window-effects.png "Disable effects of the inactive windows")

Finally, the visual effect of Dolphin becomes fresher than before.

![img](/figures/2022-07-23_09-49-48-uniform-color-in-dolphin.png "Uniform color in Dolphin")

{{ "2022-07-23-disable-alternate-colors-in-kde-plasma" | backlink }}
