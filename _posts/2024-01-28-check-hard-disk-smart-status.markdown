---
layout: post
title: Check hard disk SMART status
date: 2024-01-28
categories: [computer]
tags: [hard-disk,command]
mathjax: false
---

-   From command line
    
    ```text
    sudo smartctl -a <device-name>
    ```
    
    where `<device-name>` can be `/dev/sda`.
-   From GUI in KDE
    
    Go to &ldquo;Info Center&rdquo; → &ldquo;Devices&rdquo; → &ldquo;SMART Status&rdquo; and open &ldquo;Partition Manager&rdquo; of the target disk.
    
    ![img](/figures/2024-01-28_11-47-51-smart-status-in-kde-info-center.png)
    
    In the opened &ldquo;KDE Partition Manager&rdquo;, the SMART status can be checked and exported to an HTML file.
    
    ![img](/figures/2024-01-28_11-49-45-smart-status-parameters.png)
    
    At the moment, the &ldquo;Read Error Rate&rdquo; of my newly purchased Ironwolf 4TB disk registers a very high value `213,121,160`, in hexadecimal is `0x00000cb3f888`. According to [here](https://www.reddit.com/r/DataHoarder/comments/x9xb4d/comment/inqvrq2/?utm_source=share&utm_medium=web2x&context=3), the lowest 32 bits of this value represents the number of operations, while the highest 16 bits are the number of errors. Therefore, there is no problem with my new disk. By running Seagate&rsquo;s own disk health diagnostic tool, the reported disk status is also OK.

{{ 2024-01-28-check-hard-disk-smart-status | backlink }}
