FROM alpine:3.4

MAINTAINER Jose Jorge Lorenzo Vila <jjlorenzo@gmail.com>

ENV LANG C.UTF-8

RUN set -ex &&\
  apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community dumb-init multitail &&\
  apk add --no-cache \
    curl           \
    git            \
    monit          \
    nginx          \
    py-pip         \
    uwsgi-python &&\
  curl https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64 -L -o /usr/local/bin/gosu &&\
  chmod 0755 /usr/local/bin/gosu

RUN set -ex &&\
  addgroup -S app && adduser -G app -S -D app

# https://github.com/npm/npm/issues/9863
RUN set -ex &&\
  apk add --no-cache nodejs  &&\
  npm update --silent --global npm &&\
  npm install --silent --global \
    bower              \
    bower-npm-resolver \
    gulp             &&\
  rm -rf /root/.npm

RUN set -ex &&\
  echo $'#!/bin/sh\n\nexec "$@"' > /usr/local/bin/docker-entrypoint.sh &&\
  chmod 0755 /usr/local/bin/docker-entrypoint.sh &&\
  ln -s /usr/local/bin/docker-entrypoint.sh /

ENV PS1 "\u@\h:\w# "

ENTRYPOINT ["/usr/bin/dumb-init", "--", "/usr/local/bin/docker-entrypoint.sh"]

CMD ["/bin/sh"]
