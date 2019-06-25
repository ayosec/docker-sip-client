#!/bin/bash

set -ex

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y apt-transport-https gnupg wget

# Key for ag-projects.com repository.
#
# Unfortunately, the key has to be downloaded from an insecure HTTP server, so
# the only check that we can do is to verify its hash.

wget -O /tmp/agp-debian-key.gpg \
  http://download.ag-projects.com/agp-debian-key.gpg

echo fde47ef80a2b179c07f584d408c64b7d00fbc80e0294a89e5d8d08c2f94c6878 /tmp/agp-debian-key.gpg > /tmp/checks.sha256
sha256sum -c /tmp/checks.sha256

apt-key add /tmp/agp-debian-key.gpg

# Install Blink package

echo "deb http://ag-projects.com/debian stretch main" > /etc/apt/sources.list.d/ag.list

apt-get update
apt-get install -y blink libasound2-plugins

# User to launch the application

useradd -m -u "$HOST_UID" sip

# Configure ALSA to use PulseAudio

cat > /home/sip/.asoundrc <<EOF
pcm.pulse {
    type pulse
}
ctl.pulse {
    type pulse
}
pcm.!default {
    type pulse
}
ctl.!default {
    type pulse
}
EOF

chown sip: /home/sip/.asoundrc
