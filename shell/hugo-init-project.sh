#!/bin/bash
export HUGO_PROJECT_GIT_SSH_URI=${HUGO_PROJECT_GIT_SSH_URI:-'git@github.com:gravitee-lab/hugofied-gravitee-docs.git'}
# ---
# --- TEST 1
# ---
echo "The tests failed to imort the Jekyll project to a hugo project"
echo "---"
echo "So I create a new hugo project, add to it a folder with "
echo "the raw generated website, and initialize a git repo with the "
echo "hugo project, ready for converting the raw generated website to a proper hugo theme"
echo "---"
hugo new site gravitee-docs-hugofied
mkdir -p gravitee-docs-hugofied/raw-website-to-convert
cp -fr hugo-to-jekyll/test1/source/src/* gravitee-docs-hugofied/raw-website-to-convert/
rm -fr ./.git/
cd gravitee-docs-hugofied/
touch README.md
cp README.md content/
cp README.md data
cp README.md layouts
cp README.md static
cp README.md themes/

rm -fr raw-website-to-convert/.git/
git init
git remote add origin ${HUGO_PROJECT_GIT_SSH_URI}
git add --all && git commit -m "initial commit, gravitee-docs generated raw website is in [raw-website-to-convert/] folder" && git push -u origin HEAD
git flow init --defaults && git push -u origin --all
