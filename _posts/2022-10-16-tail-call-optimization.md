---
layout: post
title: Tail call optimization
categories: [c]
description:
keywords: c
---

Read several interesting posts related to tail call optimization.
More specificly, optimization related to the interpreter implementation.

Protobuf decoder optimization:
<https://blog.reverberate.org/2021/04/21/musttail-efficient-interpreters.html>

Wasm3 interpreter:
<https://github.com/wasm3/wasm3/blob/main/docs/Interpreter.md#m3-massey-meta-machine>

LutJIT implementation:
<https://www.reddit.com/r/programming/comments/badl2/comment/c0lrus0/>
<http://lua-users.org/lists/lua-l/2011-02/msg00742.html>


Clang supports the `[[musttail]]` attribute to help this:
<https://clang.llvm.org/docs/AttributeReference.html#musttail>


The LLVM `Call` instructions also has mustcall support:
<https://llvm.org/docs/LangRef.html#call-instruction>
