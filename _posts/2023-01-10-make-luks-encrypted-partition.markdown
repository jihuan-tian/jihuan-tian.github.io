---
layout: post
title: Make LUKS encrypted partition
date: 2023-01-10
categories: [computer]
tags: [command,hardware,security]
mathjax: false
---

I&rsquo;ve been using `veracrypt` on my Linux workstation to crypt all my data disks or partitions for a long time. Now I switch to [Linux Unified Key Setup (LUKS)](https://en.wikipedia.org/wiki/Linux_Unified_Key_Setup) for my newly purchased Seagate One Touch Desktop disk.

# Fundamental concepts

-   GPT (GUID Partition Table)
    
    ```text
    GPT is modern standard for the layout of the partition table. GPT uses 64-bit log‐ ical block addresses, checksums, UUIDs and names for partitions and an unlimited number of partitions (although the number of partitions is usually restricted to 128 in many partitioning tools).
    
    Note that the first sector is still reserved for a protective MBR in the GPT speci‐ fication. It prevents MBR-only partitioning tools from mis-recognizing and over‐ writing GPT disks.
    
    GPT is always a better choice than MBR, especially on modern hardware with a UEFI boot loader.
    ```

-   DOS-type (MBR)
    
    ```text
    A DOS-type partition table can describe an unlimited number of partitions. In sec‐ tor 0 there is room for the description of 4 partitions (called `primary'). One of these may be an extended partition; this is a box holding logical partitions, with descriptors found in a linked list of sectors, each preceding the corresponding logical partitions. The four primary partitions, present or not, get numbers 1-4. Logical partitions are numbered starting from 5.
    
    In a DOS-type partition table the starting offset and the size of each partition is stored in two ways: as an absolute number of sectors (given in 32 bits), and as a Cylinders/Heads/Sectors triple (given in 10+8+6 bits). The former is OK -- with 512-byte sectors this will work up to 2 TB. The latter has two problems. First, these C/H/S fields can be filled only when the number of heads and the number of sectors per track are known. And second, even if we know what these numbers should be, the 24 bits that are available do not suffice. DOS uses C/H/S only, Windows uses both, Linux never uses C/H/S. The C/H/S addressing is deprecated and may be unsupported in some later fdisk version.
    ```
    
    **For a partition larger than 2TB, use the GPT partition instead of MBR.**


# Procedures

1.  Check the block devices using `lsblk`. It can be seen that the new disk is `/dev/sdc`, which has two partitions already.
    
        NAME               MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
        sda                  8:0    0 465.8G  0 disk 
        ├─sda1               8:1    0  14.9G  0 part [SWAP]
        ├─sda2               8:2    0  93.1G  0 part /
        └─sda3               8:3    0 357.7G  0 part 
          └─veracrypt1_1   254:0    0 357.7G  0 dm   
            └─veracrypt1_0 254:1    0 357.7G  0 dm   
              └─veracrypt1 254:2    0 357.7G  0 dm   /home/jihuan/文档
        sdb                  8:16   0   1.8T  0 disk 
        ├─sdb1               8:17   0 548.2G  0 part 
        ├─sdb2               8:18   0 779.7G  0 part 
        ├─sdb3               8:19   0 789.9G  0 part 
        └─veracrypt2_1     254:3    0   1.8T  0 dm   
          └─veracrypt2_0   254:4    0   1.8T  0 dm   
            └─veracrypt2   254:5    0   1.8T  0 dm   /media/backup
        sdc                  8:32   0   3.6T  0 disk 
        ├─sdc1               8:33   0   200M  0 part 
        └─sdc2               8:34   0   3.6T  0 part 
        sr0                 11:0    1  1024M  0 rom
2.  Unmount partitions `/dev/sdc1` or `/dev/sdc2` if needed.
3.  Check the type of existing partitions on the disk using `gdisk`. We can see the first partition is EFI.
    
    ```bash
    sudo gdisk -l /dev/sdc
    ```
4.  Within the `gdisk` session, delete existing partitions using the `d` command.
5.  Create a new Linux LUKS partition using the `n` command. The partition type code is `8309`.
6.  Change the partition name to `Backup` using the `c` command.
7.  Use the `w` command to write out the partition table.
8.  Format the partition `/dev/sdc1` with LUKS.
    
    ```bash
    sudo cryptsetup luksFormat /dev/sdc1
    ```
9.  Open the LUKS partition and associate it with a map point named `backup`.
    
    ```bash
    sudo cryptsetup luksOpen /dev/sdc1 backup
    ```
10. Check the block devices using `lsblk` again and we can see the map point `backup` becomes a child of `sdc` in the tree view.
    
    ```text
    NAME               MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
    sda                  8:0    0 465.8G  0 disk
    ├─sda1               8:1    0  14.9G  0 part  [SWAP]
    ├─sda2               8:2    0  93.1G  0 part  /
    └─sda3               8:3    0 357.7G  0 part
    └─veracrypt1_1   254:0    0 357.7G  0 dm
    └─veracrypt1_0 254:1    0 357.7G  0 dm
    └─veracrypt1 254:2    0 357.7G  0 dm    /home/jihuan/文档
    sdb                  8:16   0   1.8T  0 disk
    ├─sdb1               8:17   0 548.2G  0 part
    ├─sdb2               8:18   0 779.7G  0 part
    ├─sdb3               8:19   0 789.9G  0 part
    └─veracrypt2_1     254:3    0   1.8T  0 dm
    └─veracrypt2_0   254:4    0   1.8T  0 dm
    └─veracrypt2   254:5    0   1.8T  0 dm    /media/backup
    sdc                  8:32   0   3.6T  0 disk
    └─sdc1               8:33   0   3.6T  0 part
    └─backup         254:6    0   3.6T  0 crypt
    sr0                 11:0    1  1024M  0 rom
    ```
11. Create an `ext4` file system in the LUKS partition.
    
    ```bash
    sudo mkfs.ext4 /dev/mapper/backup
    ```
    
    ```text
    mke2fs 1.46.2 (28-Feb-2021)
    Creating filesystem with 976750540 4k blocks and 244195328 inodes
    Filesystem UUID: 6694d01b-92b9-44cf-b4c5-83aaf748ce01
    Superblock backups stored on blocks:
    32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
    4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968,
    102400000, 214990848, 512000000, 550731776, 644972544
    
    Allocating group tables: done
    Writing inode tables: done
    Creating journal (262144 blocks): done
    Writing superblocks and filesystem accounting information: done
    ```
12. Mount the created `ext4` file system as usual.
    
    ```bash
    sudo mount /dev/mapper/backup /media/backup2
    ```
13. Run `rynsc` to backup data.
14. Umount the volume and close the LUKS partition.
    
    ```bash
    sudo umount /media/backup2
    sudo cryptsetup luksClose backup
    ```

{{ "2023-01-10-make-luks-encrypted-partition" | backlink }}
