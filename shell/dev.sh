#!/bin/bash

# --- #
echo "building gravitee-docs"
export GRAVITEE_DOCS_VERSION=${GRAVITEE_DOCS_VERSION:-'master'}
export GRAVITEE_DOCS_GIT_URI=git@github.com:gravitee-io/gravitee-docs.git
export OPS_HOME=$(pwd)

mkdir  -p ${OPS_HOME}/container/dev/gravitee-docs-repo/
git clone ${GRAVITEE_DOCS_GIT_URI} ${OPS_HOME}/container/dev/gravitee-docs-repo/
cd ${OPS_HOME}/container/dev/gravitee-docs-repo/
git checkout ${GRAVITEE_DOCS_VERSION}
export GIT_COMMIT_ID=$(git rev-parse HEAD)
cd ${OPS_HOME}
# rm -fr ${OPS_HOME}/container/dev/gravitee-docs-repo/.git


export CONTAINER_IMAGE_ID=gravitee.io/jekyll:0.0.1

docker build --build-arg GIT_COMMIT_ID=${GIT_COMMIT_ID} -t ${CONTAINER_IMAGE_ID} ${OPS_HOME}/container/dev

export GIT_COMMIT_ID_LABEL=$(docker inspect --format '{{ index .Config.Labels "oci.image.nonroot.user.name"}}' "${CONTAINER_IMAGE_ID}")
echo "GIT_COMMIT_ID_LABEL=[${GIT_COMMIT_ID_LABEL}]"

docker-compose up -d
