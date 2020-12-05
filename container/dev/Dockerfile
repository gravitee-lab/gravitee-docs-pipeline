#-------------------------------------------------------------------------------
# Copyright (C) 2015 The Gravitee team (http://gravitee.io)
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#            http://www.apache.org/licenses/LICENSE-2.0
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#-------------------------------------------------------------------------------
FROM ruby:2.7 as builder
LABEL maintainer="Gravitee Team <http://gravitee.io>"
ARG GIT_COMMIT_ID=${GIT_COMMIT_ID}
LABEL git.commit.id=${GIT_COMMIT_ID}

ENV RUBYOPT=-KU

RUN apt-get clean
RUN mv /var/lib/apt/lists /var/lib/apt/lists.broke
RUN mkdir -p /var/lib/apt/lists/partial
RUN apt-get update
RUN apt-get install -y  nodejs

WORKDIR /src

ADD gravitee-docs-repo/Gemfile /src/
ADD gravitee-docs-repo/Gemfile.lock /src/
RUN gem install bundler
RUN gem install jekyll -v 3.8.7
RUN bundle install

ADD gravitee-docs-repo/* /src/
RUN mkdir -p /src/_includes/custom
RUN mkdir -p /src/_data
RUN mkdir -p /src/_layouts
COPY gravitee-docs-repo/_includes/* /src/_includes/
COPY gravitee-docs-repo/_includes/custom/* /src/_includes/custom/
COPY gravitee-docs-repo/_data/* /src/_data/
COPY gravitee-docs-repo/_layouts/* /src/_layouts/

RUN ls -allh /src
COPY serve-dev.sh .
RUN chmod +x *.sh
RUN bundle exec jekyll build
# ---
# Now I am adding a bit more instructions to build the
# whole thing before serving the website :
# => I do not know why Jekyll does not do that
# => or why the [_config.yml] does not properly defines path for those static files to serve
# I added this because otherwise, assets files like
# css files, images, etc... are not properly served by the [bundle exec jekyll serve] command
# ---
COPY structure-for-jekyll-serve.sh .
RUN chmod +x *.sh
RUN ./structure-for-jekyll-serve.sh

EXPOSE 4000
CMD ["/src/serve-dev.sh"]
