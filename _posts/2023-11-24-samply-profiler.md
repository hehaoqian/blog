---
layout: post
title: How to use the Samply profiler
categories: [profiler]
description:
keywords:
---

I recently got curious how Rust-lang track its performance.

It uses a lot of technics as shown in <https://github.com/rust-lang/rustc-perf/tree/master/collector>

Today I will try to use [Samply](https://github.com/mstange/samply/), a sampling profiler

## Source of test suite

I use <https://github.com/phoronix-test-suite/phoronix-test-suite/> for benchmarking

It is installed by `sudo dnf install phoronix-test-suite`, whose version is v10.8.4

The specific benchmark I run is `phoronix-test-suite benchmark blake2`

The version of benchmark is `1.2.2`

The actual program is stored in `~/.phoronix-test-suite/installed-tests/pts/blake2-1.2.2/BLAKE2-20170307/bench/blake2s`

Every run takes about 1s

## Install of Samply

```sh
cargo install samply
```

## TODO

Not finished yet. Update later