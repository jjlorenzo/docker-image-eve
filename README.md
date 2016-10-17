## Alpine 3.4

A base Docker image based on Alpine Linux.

### Disabling Cache
As of Alpine Linux 3.3 there exists a new `--no-cache` option for apk. It allows users to install packages with an
index that is updated and used on-the-fly and not cached locally:

``` sh
RUN apk --no-cache add nginx
```
That will install `nginx` running first `apk update` and then `rm -rf /var/cache/apk/*`.

### Group dependencies (easy clean)
If installing like:

``` sh
RUN apk add --no-cache --virtual .build-deps pkg-1 pkg-2
```

Will allow us to remove all dependencies with just one command

``` sh
RUN apk del .build-deps
```

## Reference
- `dumb-init`: A minimal init system for Linux containers.
  [ref](https://engineeringblog.yelp.com/2016/01/dumb-init-an-init-for-docker.html)
- `monit`: small utility for managing and monitoring Unix systems
  [ref](https://blog.deimos.fr/2016/01/13/docker-why-you-should-use-monit-instead-of-supervisord/)
  [ref](http://blog.xebia.com/bootstrapping-and-monitoring-multiple-processes-in-docker-using-monit/)


## Optional run-time tools
``` sh
ca-certificates
curl
htop
mc
nano
ncdu
tmux
vim
wget
```

## Optional buil-time tools for based image

1. Install OS build-deps
2. Install Project dependencies
3. Remove build-deps in the same layer so the image size it is doesn't affected

``` sh
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
  zlib-dev       \
    &&\
  ...
  install project deps
  ...
    &&\
  apk del .build-deps
```
