---
layout: post
title: Customize the font in Firefox reader mode
date: 2022-03-24
categories: [computer]
tags: [ergonomics,eyes-protection,Firefox]
mathjax: false
---

Customizing the font family used in Firefox reader mode is helpful to increase online reading experience. This can be achieved according to the following procedure.

1. Open the address `about:support` in Firefox and open the profile folder.
   ![Open Firefox user profile folder from about:support](/figures/Screenshot_20220324_083107-firefox-about-support.png)
   <p align="center">Fig. Open Firefox user profile folder from about:support</p>
   
2. If the folder `chrome` does not exist, create it. Then create a CSS file `userContent.css` in the `chrome` folder with the following contents as example, where I’ve adopted my favorite font `KaiTi` for reading Chinese articles and `Noto Serif` for English contents.
   ```css
.moz-reader-content { 
  font-family: "KaiTi", "Noto Serif", "Times New Roman", serif;
} 
   ```
3. Open `about:config` in Firefox and change the option `toolkit.legacyUserProfileCustomizations.stylesheets` to `true`.
4. Restart Firefox to take effect.

If you want, more styles and features can be customized with the help of the Developer Tool in Firefox.

{{ 2022-03-24-customize-the-font-in-firefox-reader-mode | backlink }}
