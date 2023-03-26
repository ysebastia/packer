variable "disk_image" {
  type = string
}

variable "disk_size" {
  type = string
  default = "4G"
}

variable "iso_checksum" {
  type = string
}

variable "iso_url" {
  type = string
}

variable "name" {
  type = string
}

variable "provisioner_shell" {
  type = string
}

variable "ssh_password" {
  type = string
}

variable "ssh_username" {
  type = string
}

variable "version" {
  type = string
}

variable "vnc_port" {
  type = number
}

source "qemu" "terraform" {
  accelerator      = "kvm"
  cd_files         = ["./files/cdrom/${var.name}/*"]
  cd_label         = "cidata"
  cpus             = 2
  disk_cache       = "none"
  disk_compression = true
  disk_discard     = "unmap"
  disk_image       = var.disk_image
  disk_interface   = "virtio"
  disk_size        = var.disk_size
  format           = "qcow2"
  headless         = true
  iso_checksum     = var.iso_checksum
  iso_url          = var.iso_url
  machine_type	   = "pc"
  memory           = 2048
  net_device       = "virtio-net"
  output_directory = "artifacts/${var.name}/"
  qemu_binary      = "/usr/libexec/qemu-kvm"
  qemuargs         = [
    ["-m", "2048M"],
    ["-smp", 2],
    ["-cpu", "host,+nx"],
    ["-display", "none"]
  ]
  shutdown_command = "sudo shutdown --poweroff --no-wall now"
  ssh_password     = var.ssh_password
  ssh_timeout      = "20m"
  ssh_username     = var.ssh_username
  vm_name          = var.name
  vnc_port_min     = var.vnc_port
  vnc_port_max     = var.vnc_port
}

build {
  sources = ["source.qemu.terraform"]

  provisioner "shell" {
    execute_command = "{{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts         = [ "${var.provisioner_shell}" ]
  }

  post-processors {
    post-processor "shell-local" {
      inline = [
        "set -eu",
        "virt-sparsify --in-place artifacts/${var.name}/${var.name}",
        "qemu-img convert -f qcow2 -O qcow2 -c artifacts/${var.name}/${var.name} artifacts/${var.name}/${var.name}_${var.version}.img",
        "rm -f artifacts/${var.name}/${var.name}"
        ]
    }
  }
}
