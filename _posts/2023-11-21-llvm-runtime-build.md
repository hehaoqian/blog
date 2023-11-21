---
layout: post
title: Go through CMake code that builds LLVM Runtime
categories: [llvm]
description:
keywords:
---

## Background

The runtime component of llvm project, such as `libcxx`, `openmp`, `compiler-rt`, `libunwind`
uses different way to compile compared to the compiler component.

## Fact of runtime components

1. Google test is not used, so no `unittests` directory
2. Regression test which uses `llvm-lit` is still available
3. LLVM library such as `LLVMSupport` is not available
4. CMake function `add_llvm_library` is not used
