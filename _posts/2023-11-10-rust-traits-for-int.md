---
layout: post
title: Useful traits for integers in Rust lang
categories: [rust]
description:
keywords:
---

Why Rust lang has no built in traits for integers?

The [num-traits](https://docs.rs/num-traits/latest/num_traits/) crate is usually needed.

Here is some code examples

## Accept as primitive integer and cast to u64

```Rust
use num_traits::int::PrimInt;
use num_traits::cast::AsPrimitive;

fn int_to_u64<T>(value: T) -> u64 where T: PrimInt + AsPrimitive<u64> {
    value.as_()
}
```
