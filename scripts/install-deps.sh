#!/bin/sh

apk update
apk add tar xz sudo shadow

# nix installer expects one of the common shell profile file. We'll make one
touch /home/vagrant/.profile
chown vagrant:vagrant /home/vagrant/.profile
