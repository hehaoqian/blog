---
layout: post
title: Decrease grub automatic timeout
categories: [linux, grub]
description: 
keywords:
---

When newly installed Ubuntu in a virtual machine,
the default automatic timeout is likely to be 30s.

Add the following lines to `/etc/default/grub`
```
GRUB_RECORDFAIL_TIMEOUT=2
```

Then
```
sudo update-grub
```

Then the timeout will be 2s
