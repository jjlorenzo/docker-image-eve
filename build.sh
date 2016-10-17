#!/usr/bin/env sh

# ./build.sh
# ./build.sh watch
# BASE=ubuntu VERSION=16.04 ./build.sh
# BASE=ubuntu VERSION=16.04 ./build.sh watch

version="${VERSION:-3.4}"
base="${BASE:-alpine}"

case ${base} in
  alpine|ubuntu)
    tags="--tag jjlorenzo/eve:${base}-${version}"
    if [ "${base}" = "alpine" ] && [ "${version}" = "3.4" ]; then
      tags="${tags} --tag jjlorenzo/eve:latest"
    fi
    docker_build="docker build ${tags} ${base}/versions/${version}"
    if [ "$1" = "watch" ]; then
      nodemon --watch ${base}/versions/${version}/Dockerfile --exec ${docker_build}
    else
      ${docker_build}
    fi
  ;;
  *)
    echo "Unknown base, only alpine and ubuntu"
  ;;
esac
