# Docker Image for SIP Client

With this Docker image is it possible to use the [Blink](https://en.wikipedia.org/wiki/Blink_%28SIP_client%29) SIP client.

The image assume an X11 environment, with PulseAudio.

## Usage

To build the image:

    $ docker build --build-arg HOST_UID="$UID" -t sipclient .

To run it:

    $ ./run.sh blink
