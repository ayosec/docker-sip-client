#!/bin/sh

set -xe

GWIP="$(docker network inspect bridge -f '{{ range .IPAM.Config }}{{ .Gateway }}{{ end }}')"

PULSE_DIR="$XDG_RUNTIME_DIR"

if [ ! -d "$PULSE_DIR" ]
then
  echo "Missing $PULSE_DIR"
  exit 1
fi

docker run -ti -u sip --rm              \
  -v /tmp/.X11-unix:/tmp/.X11-unix      \
  -w /home/sip                          \
  --dns "$GWIP"                         \
  -v "$PULSE_DIR:$PULSE_DIR"            \
  -e "XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR" \
  -e "DISPLAY=$DISPLAY"                 \
  -e "GDK_SCALE=$GDK_SCALE"             \
  -e "QT_SCALE_FACTOR=$QT_SCALE_FACTOR" \
  sipclient "$@"
