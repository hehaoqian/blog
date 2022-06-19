#!/bin/bash

# Run Jekyll locally
# See https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/testing-your-github-pages-site-locally-with-jekyll

ip_address=$(hostname -I)
port=4000

echo "### IP Address is ${ip_address}"
echo "### Port is ${port}"

exec bundle exec jekyll serve --host "${ip_address}" --port "${port}"

