#!/bin/bash
# ---
sleep 3s
# ---
# --- TEST 1
# ---
mkdir -p hugo-to-jekyll/test1/source
mkdir -p hugo-to-jekyll/test1/target

docker cp jekyll_dev_repaired:/src hugo-to-jekyll/test1/source

hugo import jekyll hugo-to-jekyll/test1/source/src hugo-to-jekyll/test1/target

echo "This test gives an error because the Jekyll project does not have a [_posts] folder."

exit 0

# ---
# --- TEST 2
# ---
mkdir -p hugo-to-jekyll/test2/source
mkdir -p hugo-to-jekyll/test2/target

docker cp jekyll_dev_repaired:/src/* hugo-to-jekyll/test2/source

hugo import jekyll hugo-to-jekyll/test2/source hugo-to-jekyll/test2/target