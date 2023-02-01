variable "name" {
  type    = string
  default = "centos9s"
}

variable "version" {
  type    = string
  default = "20230129.0"
}

variable "cpu" {
  type    = string
  default = "1"
}

variable "disk_size" {
  type    = string
  default = "20G"
}

variable "headless" {
  type    = string
  default = "false"
}

variable "iso_checksum" {
  type    = string
  default = "sha256:c9c1b0f0dbd6712e1ad5641587d854d82722911db6df38abe7fb6304664b0c30"
}

variable "iso_url" {
  type    = string
  default = "file:///var/lib/libvirt/images/CentOS-Stream-9-20230123.0-x86_64-boot.iso"
}

variable "ram" {
  type    = string
  default = "2048"
}

variable "ssh_password" {
  type    = string
  default = "vagrant"
}

variable "ssh_username" {
  type    = string
  default = "vagrant"
}

source "qemu" "centos9s" {
  accelerator      = "kvm"
  boot_command     = ["<tab> inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/centos9s.cfg<enter><wait>"]
  boot_wait        = "10s"
  cpus             = var.cpu
  disk_cache       = "none"
  disk_compression = true
  disk_discard     = "unmap"
  disk_interface   = "virtio"
  disk_size        = var.disk_size
  format           = "qcow2"
  headless         = var.headless
  http_directory   = "http"
  iso_checksum     = var.iso_checksum
  iso_url          = var.iso_url
  machine_type	   = "pc"
  memory           = var.ram
  net_device       = "virtio-net"
  output_directory = "artifacts/"
  qemu_binary      = "/usr/libexec/qemu-kvm"
  qemuargs         = [
    ["-m", "${var.ram}M"],
    ["-smp", "${var.cpu}"],
    ["-cpu", "host,+nx"],
    ["-display", "none"]
  ]
  shutdown_command = "sudo shutdown --poweroff --no-wall now"
  ssh_password     = var.ssh_password
  ssh_timeout      = "20m"
  ssh_username     = var.ssh_username
  vm_name          = var.name
}

build {
  sources = ["source.qemu.centos9s"]

  post-processors {
    post-processor "shell-local" {
      inline = [
        "set -eu",
        "virt-sysprep --operations defaults,-ssh-userdir,-customize -a artifacts/${var.name}",
        "virt-sparsify --in-place artifacts/${var.name}",
        "qemu-img convert -f qcow2 -O qcow2 -c artifacts/${var.name} artifacts/${var.name}_${var.version}.img",
        ]
    }
    post-processor "vagrant" {
      keep_input_artifact = true
      compression_level   = 9
      output = "artifacts/${var.name}_vagrant_{{.Provider}}_${var.version}.box"
      provider_override   = "libvirt"
    }
    post-processor "shell-local" {
      inline = [
        "bash scripts/metadata.bash ${var.name} ${var.version} artifacts/${var.name}_vagrant_libvirt_${var.version}.box > artifacts/metadata.json"
        ]
    }
  }
}
