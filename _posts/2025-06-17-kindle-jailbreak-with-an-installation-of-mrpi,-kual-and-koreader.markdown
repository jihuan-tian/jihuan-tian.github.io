---
layout: post
title: Kindle jailbreak with an installation of MRPI, KUAL and KoReader
date: 2025-06-17
categories: [computer]
tags: [Kindle]
mathjax: false
---

According to the instructions [here](https://kindlemodding.org/), I followed these procedures:

-   Identify the model type of my Kindle device.
-   Install WinterBreak, which is a jailbreak released on New Year’s Day 2025 by HackerDude.
-   Install a hotfix which prevents Kindle from firmware update in the future.
-   Install MobileRead Package Installer (MRPI).
-   Install Kindle Unified Application Launcher (KUAL).
    
    Copy the file `Update_KUALBooklet_ALLDEVICES_KS2_install.bin` to the root directory of Kindle, then update the device. Run `;log mrpi` in the search bar does not work.
-   Install KoReader.
    -   Copy images into the file system as wallpapers.
    -   Install Stardict dictionaries, such as Oxford Advanced Learners and OED, into KoReader&rsquo;s folder `koreader/data/dict`.
        
        Convert Goldendict format dictionaries to Stardict format using Python package `pyglossary`:
        
        ```text
        pip install pyglossary
        pyglossary <dictionary>.mdx <dictionary>.ifo
        ```
    -   KoReader only has a simple Pinyin input method, no Wubi.

{{ "2025-06-17-kindle-jailbreak-with-an-installation-of-mrpi,-kual-and-koreader" | backlink }}
