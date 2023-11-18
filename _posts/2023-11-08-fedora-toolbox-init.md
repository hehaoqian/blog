---
layout: post
title: How to initialize Fedora Toolbox
categories: [fedora, toolbox]
description:
keywords:
---

Create the toolbox

```sh


toolbox enter
```

Install `etckeeper`
To auto backup `/etc` directory whenever `dnf install`

```sh
sudo dnf install etckeeper

# Init /etc/.git directory
sudo etckeeper init
```

Install development softwares

```sh
sudo dnf install vim tmux \
     ruby ruby-devel openssl-devel redhat-rpm-config gcc-c++ @development-tools \
     llvm clang clang-tools-extra ninja-build lldb automake git \
     libzstd-devel libasan libasan-static libtsan libtsan-static libubsan libubsan-static
```

Setup ssh server according to [another post](../../../../2023/11/08/fedora-toolbox-ssh/)

Add password. This is for security. Otherwise `sudo` does not need password

```sh
passwd
sudo passwd
```
