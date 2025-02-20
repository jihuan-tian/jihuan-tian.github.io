---
layout: post
title: Debian system could not start when fsckd failed for a LUKS partition
date: 2025-02-21
categories: [computer]
tags: [Linux,hard-disk]
mathjax: false
---

**Phenomenon**

My LUKS partition used for system live backup couldn&rsquo;t pass disk checking during system booting.

![img](/figures/2025-02-18-fsck-failed-for-luks2.JPG)

![img](/figures/2025-02-18-fsck-failed-for-luks1.JPG)

**Cause**

When fsck detects an error during system boot, it seems it will not try to correct the error. A manual check is needed.

**Solution**

1.  Enter the maintenance mode.
2.  Disable the automatic disk check in `/etc/fstab` by changing the last field below from the original 2 to 0<sup><a id="fnr.1" class="footref" href="#fn.1" role="doc-backlink">1</a></sup>. Then the system can start without disk checking. *Maybe this step can be omitted and execute the following steps directly in the maintenance model.*
    
    ```text
    /dev/mapper/live-backup /media/backup ext4 rw,relatime 0 0
    ```
3.  After system reboot, backup all LUKS partition headers, in case they are broken someday in the future.
    
    ```text
    sudo cryptsetup luksHeaderBackup /dev/sda4 --header-backup-file home.img
    sudo cryptsetup luksHeaderBackup /dev/sdb1 --header-backup-file live-backup.img
    ```
4.  Umount `/dev/mapper/live-backup` and manually perform disk checking and repairing.
    
    ```text
    sudo fsck -y /dev/mapper/live-backup
    ```
5.  Restore the last field for `/dev/mapper/live-backup` in `/etc/fstab` to 2 in `/etc/fstab`, then restart the system.

## Footnotes

<sup><a id="fn.1" class="footnum" href="#fnr.1">1</a></sup> The value 2 means the disk check will be checked after the root file system and 0 means disable this checking.

{{ "2025-02-19-debian-system-could-not-start-when-fsckd-failed-for-a-luks-partition" | backlink }}
