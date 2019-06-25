#!/bin/sh

set -xe

GWIP="$(docker network inspect bridge -f '{{ range .IPAM.Config }}{{ .Gateway }}{{ end }}')"

docker run -ti -u sip --rm         \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -w /home/sip                     \
  -e "DISPLAY=$DISPLAY"            \
  -e "PULSE_SERVER=tcp:$GWIP"      \
  sipclient "$@"
