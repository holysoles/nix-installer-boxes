# nix-installer-boxes
This repository generates Vagrant boxes compatible with the nix installer, as functional install tests require a Vagrant box per distro.

## Alpine
A fresh Alpine installation does not have a few common system utilities installed that are required for the nix installer: `xz`, `tar`, `sudo`, and `shadow` (for `usermod`)

# Roadmap

In the future, we should be able to build newer Alpine releases. Some ideas:
- https://developer.hashicorp.com/packer/integrations/hashicorp/vagrant/latest/components/post-processor/vagrant
