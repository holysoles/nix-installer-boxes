variable "version" {
  type    = string
  default = "${env("BOX_VERSION")}"
}
variable "release" {
  type    = string
  default = "${env("RELEASE")}"
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
  no_release = var.release != "true"
}

source "vagrant" "alpine318" {
  add_force    = true
  communicator = "ssh"
  provider     = "libvirt"
  source_path  = "generic/alpine318"
  checksum     = "c477304e422562d11cf56c157c34e8a9710ff0d03f01e4f414f409ecae598184"
  output_dir   = "artifacts/alpine318"
}

build {
  sources = ["source.vagrant.alpine318"]

  provisioner "shell" {
    execute_command = "{{.Vars}} sudo -S -E sh '{{.Path}}'"
    script = "scripts/install-deps.sh"
  }

  post-processors {
    post-processor "vagrant-cloud" {
	no_release = local.no_release
        box_tag = "nix-installer/alpine318"
        version = "${var.version}"
      }
  }
}
