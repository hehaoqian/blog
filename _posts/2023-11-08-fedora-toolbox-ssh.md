---
layout: post
title: How to enable ssh server in Fedora toolbox
categories: [fedora, toolbox]
description:
keywords:
---

I installed Fedora Silverblue recently.
It is a immutable Linux distribution, which have read-only root directory,
and so do not encourage to install software directly on the host machine.

I like this, because it keeps the system clean.
But development software has to been installed in virtualized container, which is managed by a software called `toolbox`, which is powered by `podman`

I need to enable ssh, so I can use `ssh` to connect to the container on my Windows machine. I have two PCs, one is Linux and the other is Windows. I usually work on Windows because Linux GUI sucks.

## The method

The method comes from [Fedora Forum](https://discussion.fedoraproject.org/t/ssh-into-a-toolbox/2155/12)

First enter the toolbox in shell

```sh
toolbox enter
```

Then login into root user

```sh
sudo su
```

Then install `openssh-server`

```sh
[root@toolbox ~]# dnf install -y openssh-server
```

then generate ssh keys of ssh server

```sh
⬢[root@toolbox ~]# /usr/libexec/openssh/sshd-keygen dsa
⬢[root@toolbox ~]# /usr/libexec/openssh/sshd-keygen rsa
⬢[root@toolbox ~]# /usr/libexec/openssh/sshd-keygen ecdsa
⬢[root@toolbox ~]# /usr/libexec/openssh/sshd-keygen ed25519
```

Open /etc/ssh/sshd_config to change the line with:

```text
# Port 22

# AddressFamily any
```

in

```text
Port 2222
# AddressFamily any
```

And you can now fire the sshd with:
(This needs to be done every time the container is started, unlike previous steps)

```sh
[root@toolbox ~]# /usr/sbin/sshd
```
