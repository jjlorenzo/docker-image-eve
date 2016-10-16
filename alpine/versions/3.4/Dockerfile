FROM alpine:3.4

MAINTAINER Jose Jorge Lorenzo Vila <jjlorenzo@gmail.com>

ENV LANG C.UTF-8

RUN apk add --no-cache --virtual .build-deps \
  autoconf       \
  automake       \
  build-base     \
  file           \
  freetype-dev   \
  jpeg-dev       \
  lcms2-dev      \
  libpng-dev     \
  libwebp-dev    \
  nasm           \
  openjpeg-dev   \
  postgresql-dev \
  python-dev     \
  tiff-dev       \
  zlib-dev

RUN apk add --no-cache \
  ca-certificates \
  curl            \
  htop            \
  mc              \
  nano            \
  ncdu            \
  tmux            \
  vim             \
  wget

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
  dumb-init

RUN apk add --no-cache \
  git    \
  monit  \
  nginx  \
  py-pip \
  uwsgi

# All npm 3.X global/local packages must be in the same docker layer
# https://github.com/npm/npm/issues/9863
RUN apk add --no-cache nodejs  &&\
  npm update --silent --global npm &&\
  npm install --silent --global \
    babel-cli          \
    bower              \
    bower-npm-resolver \
    gulp               \
    http-server        \
    nodemon            \
    webpack

RUN echo $'#!/bin/sh\n\nexec "$@"' > /usr/local/bin/docker-entrypoint.sh &&\
  chmod 0755 /usr/local/bin/docker-entrypoint.sh &&\
  ln -s /usr/local/bin/docker-entrypoint.sh /

EXPOSE 80 443 2812 3000 8000

ENTRYPOINT ["/usr/bin/dumb-init", "--", "/usr/local/bin/docker-entrypoint.sh"]

CMD ["/bin/sh"]
