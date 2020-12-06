#!/bin/bash

# --- #
echo "building gravitee-docs"
export GRAVITEE_DOCS_VERSION=${GRAVITEE_DOCS_VERSION:-'master'}
export GRAVITEE_DOCS_GIT_URI=git@github.com:gravitee-io/gravitee-docs.git
export OPS_HOME=$(pwd)

mkdir  -p ${OPS_HOME}/container/dev-repaired/gravitee-docs-repo/
git clone ${GRAVITEE_DOCS_GIT_URI} ${OPS_HOME}/container/dev-repaired/gravitee-docs-repo/
cd ${OPS_HOME}/container/dev-repaired/gravitee-docs-repo/
git checkout ${GRAVITEE_DOCS_VERSION}
export GIT_COMMIT_ID=$(git rev-parse HEAD)
cd ${OPS_HOME}
# rm -fr ${OPS_HOME}/container/dev-repaired/gravitee-docs-repo/.git
# ---
# So replacing the original Dockerfile with my Dockerfile tostart the Jekyll dev server instead of ungin NGINX
cp ${OPS_HOME}/container/dev-repaired/gravitee-docs-repo/Dockerfile ${OPS_HOME}/container/dev-repaired/gravitee-docs-repo/Dockerfile.original
cp ${OPS_HOME}/container/dev-repaired/Dockerfile ${OPS_HOME}/container/dev-repaired/gravitee-docs-repo/
# also copyingthe start script
cp ${OPS_HOME}/container/dev-repaired/serve-dev.sh ${OPS_HOME}/container/dev-repaired/gravitee-docs-repo/
# ---



echo "GIT_COMMIT_ID=${GIT_COMMIT_ID}" > ./container/dev-repaired/.env
exit 0
# docker-compose build
export CONTAINER_IMAGE_ID=gravitee.io/jekyll:0.0.1-dev
docker build --build-arg GIT_COMMIT_ID=${GIT_COMMIT_ID} -t ${CONTAINER_IMAGE_ID} ${OPS_HOME}/container/dev-repaired

export GIT_COMMIT_ID_LABEL=$(docker inspect --format '{{ index .Config.Labels "oci.image.nonroot.user.name"}}' "${CONTAINER_IMAGE_ID}")
echo "GIT_COMMIT_ID_LABEL=[${GIT_COMMIT_ID_LABEL}]"
