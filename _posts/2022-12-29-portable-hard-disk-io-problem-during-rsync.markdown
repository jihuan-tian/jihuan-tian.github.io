---
layout: post
title: Portable hard disk IO problem during rsync
date: 2022-12-29
categories: [computer]
tags: [Linux,command,hardware]
mathjax: false
---

Yesterday, when making data backup to my portable hard disk West Digital My Passport WD20, I ran about `rsync` IO problem, which was probably caused by damaged sectors. Then I used the following procedures to check and repair bad blocks.

1.  Use the `dmesg` command (for printing or controlling the kernel ring buffer) to check the hard disk errors. It is clear that there are many critical medium errors on the device `/dev/sdc`.
    
    ```text
    [161861.101324] sd 6:0:0:0: [sdc] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=6s
    [161861.101330] sd 6:0:0:0: [sdc] tag#0 Sense Key : Medium Error [current] 
    [161861.101333] sd 6:0:0:0: [sdc] tag#0 Add. Sense: Unrecovered read error
    [161861.101337] sd 6:0:0:0: [sdc] tag#0 CDB: Read(10) 28 00 9e 00 33 40 00 00 c8 00
    [161861.101341] blk_update_request: critical medium error, dev sdc, sector 2650813248 op 0x0:(READ) flags 0x80700 phys_seg 25 prio class 0
    
    [163206.145345] sd 6:0:0:0: [sdc] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=3s
    [163206.145351] sd 6:0:0:0: [sdc] tag#0 Sense Key : Medium Error [current] 
    [163206.145354] sd 6:0:0:0: [sdc] tag#0 Add. Sense: Unrecovered read error
    [163206.145358] sd 6:0:0:0: [sdc] tag#0 CDB: Read(10) 28 00 9e 80 08 58 00 00 08 00
    [163206.145363] blk_update_request: critical medium error, dev sdc, sector 2659190872 op 0x0:(READ) flags 0x3000 phys_seg 1 prio class 0
    [163206.145427] EXT4-fs error (device dm-7): __ext4_get_inode_loc_noinmem:4506: inode #83102912: block 332398827: comm ls: unable to read itable block
    ```
2.  Since the ext4 volume on the hard disk is encrypted by VeraCrypt, we should check to which system device the VeraCrypt volume is mapped.
    
    ```bash
    # -t: run veracrypt in text mode.
    # -l: list mounted volumes.
    veracrypt -t -l
    ```
 
         3: /dev/sdc /dev/mapper/veracrypt3 - 
 
    No.3 is assigned to the volume. The displayed system device `/dev/mapper/veracrypt3` is only a symbolic link, which is associated with `/dev/dm-7`:
    
    ```bash
    ls -l /dev/mapper/veracrypt3
    ```

        lrwxrwxrwx 1 root root 7 Dec 29 10:15 /dev/mapper/veracrypt3 -> ../dm-7
3.  Use `testdisk` to check the addresses of superblock backups and the block size, in case the default super lock is damaged and needs a repair.
    
    ```bash
    sudo testdisk /dev/dm-7
    ```
    
    ![img](/figures/2022-12-29_10-04-22-testdisk-for-superblock.png)
4.  Umount the volume before checking and repairing it.
    
    ```bash
    sudo umount /media/backup2
    ```
5.  Check and repair the volume using the command `fsck.ext4`, which actually executes `e2fsck`.
    
    ```bash
    fsck.ext4 -p -c /dev/dm-7
    ```
    
    If the default superblock is damaged, run the command
    
    ```bash
    fsck.ext4 -p -c -b superblock -B blocksize /dev/dm-7
    ```
    
    Meaning of the command options of `e2fsck`:
    
    ```text
    -b Use an alternative superblock instead of the default one, if the default one is damaged.
    -B superblock specify the superblock size
    -c This  option  causes e2fsck to use badblocks(8) program to do a read-only scan of the device in order to find any bad blocks.  If any bad blocks are found, they are added to the bad block inode to prevent them from being allocated to a file or directory.
    -p Automatically  repair ("preen") the file system.  This option will cause e2fsck to automatically fix any filesystem problems that can be safely fixed without human intervention.  If e2fsck discovers a problem which may require the system administrator to take additional corrective action, e2fsck will print a description of the problem and then exit with the value 4  logically  or'ed  into the exit code.
    ```

{{ 2022-12-29-portable-hard-disk-io-problem-during-rsync | backlink }}
