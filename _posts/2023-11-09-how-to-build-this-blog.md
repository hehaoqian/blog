---
layout: post
title: How to build this blog
categories: [jekyll]
description:
keywords:
---

1. Follow github tutorial [Testing your GitHub Pages site locally with Jekyll](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/testing-your-github-pages-site-locally-with-jekyll),
to install `Jekyll` and `bundle` on Linux or WSL
2. git clone this blog
3. For Chinese users, in the directory of blog source code, setup mirror for Rubygems, otherwise the next step will take forever

   ```sh
   bundle config mirror.https://rubygems.org https://mirrors.tuna.tsinghua.edu.cn/rubygems
   ```

4. Install dependencies specific for this blog. Execute the following commands in the blog directory

   ```sh
   bundle install
   ```

5. Execute the script `serve_locally.sh` to serve the blog. Read the output of script to get the URL. The blog will be automatically rebuild whenever a post is added or updated

6. Note that no settings required on Github side. It will be automatically built when git pushed to Github