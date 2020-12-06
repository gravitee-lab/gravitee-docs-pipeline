#!/bin/bash

# --- #
# ---
# Now I am adding a bit more instructions to build the
# whole thing before serving the website :
# => I do not know why Jekyll does not do that
# => or why the [_config.yml] does not properly defines path for those static files to serve
# I added this because otherwise, assets files like
# css files, images, etc... are not properly served by the [bundle exec jekyll serve] command
# ---
# I thinkthe nginx configmight remapthose paths properly
# --- #

echo "Completing Static site structure before serving with Jekyll dev server"

cd /src/
mkdir -p css/
cp *.css css/


mkdir -p js/
cp *.js js/

mkdir -p images/
cp *.png images/

# +++ IBM Plex Web Library
#
# [./fonts/plex/css/] is Where IBM Plex lib [ibm-plex.css] file will be installed
mkdir -p ./fonts/plex/css/
# Missing IBM Plex
export IBM_PLEX_VERSION=5.1.3
wget -O ./ibm-plex-web-v${IBM_PLEX_VERSION}.zip https://github.com/IBM/plex/releases/download/v${IBM_PLEX_VERSION}/Web.zip

mkdir -p ./fonts/plex/unzipped

unzip ./ibm-plex-web-v${IBM_PLEX_VERSION}.zip -d ./fonts/plex/unzipped
# bundle exec jekyll serve --host 0.0.0.0 --port 4000
cp ./fonts/plex/unzipped/Web/css/*.css ./fonts/plex/css/
mv ibm-plex-web-v5.1.3.zip fonts/plex



# Web fonts from IBM Plex lib
# http://${HOSTNAME}:4000/fonts/plex/IBM-Plex-Sans/fonts/split/woff2/IBMPlexSans-Regular-Latin1.woff2
#                       ./fonts/plex/unzipped/Web/IBM-Plex-Sans/fonts/split/woff2/

mkdir -p ./fonts/plex/IBM-Plex-Sans/fonts/split/woff2/
cp ./fonts/plex/unzipped/Web/IBM-Plex-Sans/fonts/split/woff2/* ./fonts/plex/IBM-Plex-Sans/fonts/split/woff2/

mkdir -p ./fonts/plex/IBM-Plex-Sans/fonts/complete/woff2/
cp ./fonts/plex/unzipped/Web/IBM-Plex-Sans/fonts/complete/woff2/* ./fonts/plex/IBM-Plex-Sans/fonts/complete/woff2/

mkdir -p ./fonts/plex/IBM-Plex-Sans/fonts/complete/woff/
cp ./fonts/plex/unzipped/Web/IBM-Plex-Sans/fonts/complete/woff/* ./fonts/plex/IBM-Plex-Sans/fonts/complete/woff/




rm -fr ./fonts/plex/unzipped
