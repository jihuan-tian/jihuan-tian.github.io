---
layout: post
title: Share files between Linux, Windows and iOS
date: 2023-04-01
categories: [computer]
tags: [Linux,network,Samba]
mathjax: false
---

# Mount Windows or Samba shared folders from Linux

-   Access the shared folder directly from Dolphin: The user name should be prefixed with the domain name. For Windows on personal computers, the domain name is `WORKGROUP` by default. For company computers, it is usually the corporate name. Then the complete user name is `<domain-name>\<user-name>`. N.B. In URL encoding, the backslash is transcribed as `%5C`.
-   Mount a Windows shared folder to Linux directory tree from command line: Install the package `cifs-utils`. Then execute
    
    ```text
    sudo mount -t cifs //<server-ip-address>/<folder-name> /<mount-point> -o user=<user-name>,uid=<uid>,gid=<gid>,rw
    ```
    
    Among the arguments for the `-o` option:
    
    -   `user` specifies the login name for Windows;
    -   `uid` and `gid` are used to set the owner of the mount point on Linux;
    -   `rw` sets the file access rights to read and write.
-   Mount a Samba shared folder from Linux: use the same command as above.


# Access Linux Samba shared folders from Windows

Even though a Linux user account can be used as a Samba account, we need to set a new password for it using the `pdbedit` command.

```text
pdbedit -a -u <user-name>
```


# Save files from iOS to Linux Samba shared folders

Using the &ldquo;File&rdquo; application on iOS, we can connect to a Linux samba server. However, with a default Samba server configuration, we cannot successfully save files from iOS to shared folders.

Solution ([reference](https://unix.stackexchange.com/a/487094)): add the following line to the global option of Samba, i.e. in the file `/etc/samba/smb.conf`:

```text
vfs objects = acl_xattr catia fruit streams_xattr
```

After adding the option, restart Samba:

```bash
sudo smbcontrol smbd reload-config
```
