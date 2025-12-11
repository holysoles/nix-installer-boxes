# nix-installer-boxes
This repository generates Vagrant boxes compatible with the nix installer, as functional install tests require a Vagrant box per distro.

The `macos-latest` GitHub runners already have vagrant and virtualbox pre-installed, shoutout to [jonashackt for documenting this](https://github.com/jonashackt/vagrant-github-actions). However, the ubuntu-latest do not natively include these packages, but we are interested in generating libvirt boxes. This requires a fair amount of setup in the CI job.

## Alpine
A fresh Alpine installation does not have a few common system utilities installed that are required for the nix installer: `xz`, `tar`, `sudo`, and `shadow` (for `usermod`)

# Roadmap

In the future, we should be able to build newer Alpine releases. Some ideas:
- https://developer.hashicorp.com/packer/integrations/hashicorp/vagrant/latest/components/post-processor/vagrant
- https://developer.hashicorp.com/packer/guides/packer-on-cicd/pipelineing-builds#starting-from-an-iso
