FROM ubuntu:16.04

MAINTAINER Jose Jorge Lorenzo Vila <jjlorenzo@gmail.com>

ENV LANG C.UTF-8

ARG DEBIAN_FRONTEND=noninteractive

RUN sed -i 's/^deb\-src/\#deb\-src/' /etc/apt/sources.list &&\
  echo 'APT::Install-Recommends "false";' >> /etc/apt/apt.conf.d/docker-clean &&\
  echo 'APT::Install-Suggests "false";'   >> /etc/apt/apt.conf.d/docker-clean &&\
  echo 'APT::Get::Assume-Yes "true";'     >> /etc/apt/apt.conf.d/docker-clean

RUN apt-get update && apt-get -qq -o=Dpkg::Use-Pty=0 install ca-certificates curl &&\
  curl https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64.deb --location --output dumb-init.deb &&\
  dpkg -i dumb-init.deb &&\
  rm dumb-init.deb &&\
  apt-get -qq -o=Dpkg::Use-Pty=0 install \
    git               \
    monit             \
    nginx-core        \
    python-pip        \
    python-setuptools \
    uwsgi-core      &&\
  rm -rf /var/lib/apt/lists/*
  
# https://github.com/npm/npm/issues/9863
RUN \
  # curl https://deb.nodesource.com/node_4.x/pool/main/n/nodejs/nodejs_4.6.0-1nodesource1~xenial1_amd64.deb --output node.deb &&\
  curl https://deb.nodesource.com/node_6.x/pool/main/n/nodejs/nodejs_6.8.1-1nodesource1~xenial1_amd64.deb --output node.deb &&\
  dpkg -i node.deb &&\
  rm node.deb &&\
  npm update --silent --global npm &&\
  npm install --silent --global \
    bower              \
    bower-npm-resolver \
    gulp             &&\
  rm -rf /root/.npm
  
RUN echo '#!/bin/sh\n\nexec "$@"' > /usr/local/bin/docker-entrypoint.sh &&\
  chmod 0755 /usr/local/bin/docker-entrypoint.sh &&\
  ln -s /usr/local/bin/docker-entrypoint.sh /

ENTRYPOINT ["/usr/bin/dumb-init", "--", "/usr/local/bin/docker-entrypoint.sh"]

CMD ["/bin/sh"]
