# The Gravitee Docs Pipeline

## The Dev Flow

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
