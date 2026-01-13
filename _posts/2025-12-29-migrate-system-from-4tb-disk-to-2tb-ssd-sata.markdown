---
layout: post
title: Migrate system from 4TB disk to 2TB SSD SATA
date: 2025-12-29
categories: [computer]
tags: [hard-disk]
mathjax: false
---

My old system disk has 4 TB space, while the new SATA SSD disk only has 2 TB. Therefore, with Clonezilla, I cannot perform a whole disk migration, but only partition based migration.

Procedures for the migration are listed below.

1.  Check the partition table on the old disk using `sudo gdisk -l`.
    
    ```text
    Number  Start (sector)    End (sector)  Size       Code  Name
    1            2048        31250431   14.9 GiB    8200  Linux swap
    2        31250432      2177685503   1023.5 GiB  8303  Linux x86 root (/)
    3              34            2047   1007.0 KiB  EF02  BIOS boot partition
    4      2178734080      7814037134   2.6 TiB     8309  home
    5      2177685504      2178734079   512.0 MiB   EF00  EFI-system
    ```

2.  Partition the new disk. The swap partition, BIOS boot partition and EFI-system partition have the same sizes as before. The root partition is reduced to 500 GB. The remaining space on the 2 TB disk belongs to the home partition.

3.  Format the swap partition using `mkswap`, the EFI partition using `mkfs.fat -F`.

4.  Reboot to Debian live USB.

5.  Resize root partition of the old disk to 500GB.

6.  Reboot to Clonezilla and copy the root partition from the old disk to the new disk.

7.  Shutdown the system. Unplug the old disk and connect the new disk to SATA 3.0 port.

8.  Reboot to Debian live USB and do not boot into the old system. N.B. This is very important for a correct installation of grub and EFI.

9.  Mount the new root partition on the new disk to `/mnt`. Mount the EFI partition to `/mnt/boot/efi`. Bind system directories:
    
    ```bash
    sudo mount --bind /dev /mnt/dev
    sudo mount --bind /proc /mnt/proc
    sudo mount --bind /sys /mnt/sys
    ```
    
    Change the root directory of the shell to the mounted root partition `/mnt`: `sudo chroot /mnt`. Because of the previous binding system directory, the live system&rsquo;s directories `/dev`, `/prodc` and `/sys` are available in the chroot environment. Then GRUB can see the disks and `update-grub` can detect file systems and UUIDs.

10. Install grub and EFI to the new disk.
    
    ```bash
    sudo grub-install --target=i386-pc /dev/sdb
    sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB update-grub
    ```
    
    Run `sudo update-grub`.

11. Modify the UUID for the root partition in `/etc/crypttab` and `/etc/fstab`. It should now be the UUID of the partition on the new disk.

12. Reboot to the system on the new disk.

13. Make LUKS and ext4 file system for the home partition on the new disk.
    
    ```bash
    sudo cryptsetup luksFormat /dev/sdb5
    sudo cryptsetup open /dev/sdb5 newhome
    sudo mkfs.ext4 /dev/mapper/newhome
    ```

14. Mount the home partition on the old disk and copy data to the new disk.

15. Modify the UUID of the swap partition not only in `/etc/fstab`, but also in `/etc/initramfs-tools/conf.d/resume`. Then update Initramfs: `sudo update-initramfs -u`, then reboot.

{{ "2025-12-29-migrate-system-from-4tb-disk-to-2tb-ssd-sata" | backlink }}
