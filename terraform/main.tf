resource "libvirt_volume" "ubuntu2204" {
  name   = "ubuntu2204"
  source = var.image
  format = "qcow2"
  pool   = var.pool
}

resource "libvirt_network" "terraform_network" {
  name = "terraform_network"
  mode = "nat"
  autostart = "true"
  addresses = ["${var.network}.0/24"]
}

