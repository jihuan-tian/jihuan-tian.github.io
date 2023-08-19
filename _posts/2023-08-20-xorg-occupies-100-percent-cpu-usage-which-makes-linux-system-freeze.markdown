---
layout: post
title: Xorg occupies 100% CPU usage which makes Linux system freeze
date: 2023-08-20
categories: [computer]
tags: [NVIDIA,bug]
mathjax: false
---

This phenomenon appears randomly and seems more frequent when the system is idle. For example, if I wait and let the monitor in power saving mode, or if I simply lock the screen for a while, when I come back again, the system is more probable to freeze.

I checked the system log `/var/log/syslog` and found the message &ldquo;GPU has fallen off the bus&rdquo; with the error code `Xid=79`. This code implies power issues. However, my NVIDIA card only consumes less than 30W power and for most of the time, it works properly and the said problem only appear while system is idle. Therefore, I&rsquo;m quite sure that my NVIDIA card and power supply unit have no power issues.

```text
Aug 16 19:25:51 QuantumHome kernel: [85385.218434] NVRM: GPU at PCI:0000:01:00: GPU
-cf1e233c-f6d6-2924-c14e-5a7dd3f34016
Aug 16 19:25:51 QuantumHome kernel: [85385.218456] NVRM: Xid (PCI:0000:01:00): 79,
pid='<unknown>', name=<unknown>, GPU has fallen off the bus.
Aug 16 19:25:51 QuantumHome kernel: [85385.218460] NVRM: GPU 0000:01:00.0: GPU has
fallen off the bus.
Aug 16 19:25:51 QuantumHome kernel: [85385.218490] NVRM: GPU 0000:01:00.0: GPU seri
al number is <FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF>
<FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF>
<FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF>
<FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF><FF>
<FF><FF><FF><FF><FF><FF><FF><FF><FF><FF>.
Aug 16 19:25:51 QuantumHome kernel: [85385.218505] NVRM: A GPU crash dump has been
created. If possible, please run
Aug 16 19:25:51 QuantumHome kernel: [85385.218505] NVRM: nvidia-bug-report.sh as ro
ot to collect this data before
Aug 16 19:25:51 QuantumHome kernel: [85385.218505] NVRM: the NVIDIA kernel module is unloaded.
Aug 16 19:26:30 QuantumHome kernel: [85423.585708] nvidia-modeset: ERROR: GPU:0: Failed to query display engine channel state: 0x0000c67e:0:0:0x0000000f
```

I executed `sudo nvidia-bug-report.sh`. In the generated report, I could see several DKMS builds of NVIDIA kernel module after recent Linux kernel upgrades:

```text
*** /var/lib/dkms/nvidia/515.65.01/5.10.0-21-amd64/x86_64/log/make.log
*** ls: -rw-r--r-- 1 root root 28813 2023-01-24 20:28:41.040959053 +0800 /var/lib/d
kms/nvidia/515.65.01/5.10.0-21-amd64/x86_64/log/make.log
DKMS make.log for nvidia-515.65.01 for kernel 5.10.0-21-amd64 (x86_64)

*** /var/lib/dkms/nvidia/515.65.01/5.10.0-23-amd64/x86_64/log/make.log
*** ls: -rw-r--r-- 1 root root 28813 2023-05-14 06:17:10.852339523 +0800 /var/lib/dkms/nvidia/515.65.01/5.10.0-23-amd64/x86_64/log/make.log
DKMS make.log for nvidia-515.65.01 for kernel 5.10.0-23-amd64 (x86_64)

*** /var/lib/dkms/nvidia/515.65.01/5.10.0-24-amd64/x86_64/log/make.log
*** ls: -rw-r--r-- 1 root root 28813 2023-08-12 06:49:38.949305502 +0800 /var/lib/dkms/nvidia/515.65.01/5.10.0-24-amd64/x86_64/log/make.log
DKMS make.log for nvidia-515.65.01 for kernel 5.10.0-24-amd64 (x86_64)
```

Then I booted the system into the older kernels 5.10.0-21 and 5.10.0-23, both of them performed even worse: as long as I locked the screen, the system would immediately freeze. However, in the first half of this year, I did not meet such system freeze problem. Meanwhile, the NVIDIA driver 515.65.01 have been installed since last December without any update. Therefore, I guess the cause of the problem may not be the Linux kernel or NVIDIA driver.

Focusing on the power factor, the culprit may be some PCI power management strategy. According to [here](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/power_management_guide/aspm), it is probably due to ASPM:

> Active-State Power Management (ASPM) saves power in the Peripheral Component Interconnect Express (PCI Express or PCIe) subsystem by setting a lower power state for PCIe links when the devices to which they connect are not in use. ASPM controls the power state at both ends of the link, and saves power in the link even when the device at the end of the link is in a fully powered-on state.

So I executed `sudo vi /etc/default/grub` and appended `pcie_aspm=off` to `GRUB_CMDLINE_LINUX_DEFAULT`. Then I ran `sudo update-grub` and rebooted the system. Now the system have run for a whole day smoothly. Hope such boot option modification will solve the problem.

Other tried solutions which now I think may not be related:

1.  Run `nvidia-settings`, set the PowerMizer preferred mode as &ldquo;maximum&rdquo;.
2.  Turn off the `nvidia-suspend` service.
