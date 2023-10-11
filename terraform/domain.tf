data "template_file" "vm_user_data" {
  count = var.nb_vm
  template = file("${path.module}/templates/cloud_init.yml")
  vars = {
    hostname = "vm${count.index + 1}"
    public_key = file(var.public_key)
    proxy = var.proxy
    user = var.user
  }
}

data "template_cloudinit_config" "vm_config" {
  count = var.nb_vm
  gzip = false
  base64_encode = false
  part {
    filename = "init.cfg"
    content_type = "text/cloud-config"
    content = data.template_file.vm_user_data[count.index].rendered
  }
}

data "template_file" "vm_network_config" {
  count = var.nb_vm
  template = file("${path.module}/templates/network_config.yml")
  vars = {
    ipv4 = "[${var.network}.1${count.index + 1}/24]"
    gw = var.gw
    dns = var.dns
  }
}

resource "libvirt_volume" "vm_os" {
  count = var.nb_vm
  name   = "vm${count.index + 1}_os.qcow2"
  pool   = var.pool
  format = "qcow2"
  base_volume_id  = libvirt_volume.ubuntu2204.id
  size   = 5 * 1024 * 1024 * 1024
}

resource "libvirt_cloudinit_disk" "vm_commoninit" {
  count = var.nb_vm
  name = "vm${count.index + 1}_commoninit.iso"
  pool = var.pool
  user_data      = data.template_cloudinit_config.vm_config[count.index].rendered
  network_config = data.template_file.vm_network_config[count.index].rendered
}

resource "libvirt_domain" "vm_domain" {
  count = var.nb_vm
  name = "vm${count.index + 1}"
  memory = 2048
  vcpu = 1
  qemu_agent = false

  disk {
       volume_id = libvirt_volume.vm_os[count.index].id
  }
  network_interface {
       network_name = "terraform_network"
       wait_for_lease = false
  }

  cloudinit = libvirt_cloudinit_disk.vm_commoninit[count.index].id

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  graphics {
    type = "vnc"
    listen_type = "address"
    autoport = "true"
  }
}
