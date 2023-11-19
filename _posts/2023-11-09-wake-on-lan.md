---
layout: post
title: How to use wake on lan to wake up PC
categories: [linux, wol]
description:
keywords:
---

## Background

The linux PC of mine consumes too much power (and it is loud),
so it is auto suspended if keeps idle for 15min.
I use wake on line to wake it up from my Windows PC

## Steps on Linux

1. Enable it in BIOS. Ensure the LED light of ethernet card is on when PC is off.
2. Record the MAC address of the ethernet card

## Steps on Windows

1. Download [Aquila WakeOnLAN](https://wol.aquilatech.com/)
2. Install it
3. Add a `Shell` user session in `MobaXterm` (This is the terminal I use for ssh).
   Startup directory is `C:\Program Files\Aquila Technology\WakeOnLAN`.
   "Execute the following commands at startup:"

   ```sh
   ./WakeOnLanC.exe -mac ab:cd:ef:12:34:56 -w
   exit
   ```

4. In "Bookmark settings", do not check "Display reconnection message at session end". So the user session can be automatically exited after used
