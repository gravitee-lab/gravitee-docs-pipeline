# The Gravitee Docs Pipeline

## How to


```bash
#
export FEATURE_ALIAS='official-build-n-run'
export G33IO_DOCS_PIPELINE_VERSION="feature/${FEATURE_ALIAS}"
git clone git@github.com:gravitee-lab/gravitee-docs-pipeline.git
cd gravitee-docs-pipeline/
git checkout "${G33IO_DOCS_PIPELINE_VERSION}"
# export GRAVITEE_DOCS_VERSION=0.18.0
export GRAVITEE_DOCS_VERSION=develop

# Build the different images
./shell/dev.sh
./shell/dev-repaired.sh
./shell/gravitee.sh
./shell/gravitee-repaired.sh

docker-compose up -d jekyll_nginx
docker-compose up -d jekyll_dev_repaired

./shell/hugo-import.sh

docker-compose up -d jekyll_dev

# - dev teardown :
# docker-compose down && docker system prune -f --all && docker system prune -f --volumes && cd && rm -fr gravitee-docs-pipeline/

```
* When the import from Jekyll to a Hugo project fails, I :
  * create an empty git repo to start a new hugo project, from the raw generated website
  * and execute :

```bash
# --- GIT CONFIG
git config --global commit.gpgsign true
git config --global user.name "Jean-Baptiste-Lasselle"
git config --global user.email jean.baptiste.lasselle.pegasus@gmail.com
git config --global user.signingkey 7B19A8E1574C2883
# Now, to sign Git commits, for example inside an SSH session (where TTY is a bit different ...)
export GPG_TTY=$(tty)

git config --global --list

# will re-define the default identity in use
# https://docstore.mik.ua/orelly/networking_2ndEd/ssh/ch06_04.htm
ssh-add ~/.ssh.perso.backed/id_rsa

export GIT_SSH_COMMAND='ssh -i ~/.ssh.perso.backed/id_rsa'
ssh -Ti ~/.ssh.perso.backed/id_rsa git@github.com

# sets the URI of the GIT SSH URI of the empty
# git repo where the newHugo projet is to be started
export HUGO_PROJECT_GIT_SSH_URI=git@github.com:gravitee-lab/hugofied-gravitee-docs.git
./shell/hugo-init-project.sh

```

## The Dev Flow


#### Version `0.0.1-alpha`
* On a machine where you have `docker` and `docker-compose` installed, run this,andyou will be able to access the Gravitee.io Jekyll documentation :

```bash
#
export G33IO_DOCS_PIPELINE_VERSION=0.0.1-alpha
git clone git@github.com:gravitee-lab/gravitee-docs-pipeline.git
cd gravitee-docs-pipeline/
git checkout "${G33IO_DOCS_PIPELINE_VERSION}"
# export GRAVITEE_DOCS_VERSION=0.18.0
export GRAVITEE_DOCS_VERSION=develop
./shell/dev.sh
./shell/dev.sh

docker-compose up
```

In this mode, the Jekyll website is served using the `bundle exec jekyll serve` command, like suggested by the `README.md` in the https://github.com/gravitee-docs website.



#### Errors I still have

When the wbesite is displayed, I still do not have the sidebar menu
but all pages are available : I tested that usingthe same paths than on the deployed https://docs.gravitee.io website.


#### Problems that I met

I used the `bundle exec jekyll serve` command, like suggested by
the `README.md` in the https://github.com/gravitee-docs website.

Neverthe less, using the `bundle exec jekyll serve`, I had to "repair" the build, before
the website is properly served (although I stilldonothave the menu sidebar) :
* I had toinstall myself the IBM Plex Web Library
* I had to restructure the folder structure, to place js css and images assetswhere they should be to be properly served.
