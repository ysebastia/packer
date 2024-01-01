variable "public_key" {
  type = string
  default = "~/.ssh/id_ecdsa.pub"
}
variable "network" {
  type = string
  default = "192.168.100"
}
variable "dns" {
  type = string
  default = "[192.168.100.1]"
}
variable "gw" {
  type = string
  default = "192.168.100.1"
}
variable "image" {
  type = string
  default = "/var/lib/libvirt/images/jammy-server-cloudimg-amd64_20230401.img"
}
variable "proxy" {
  type = string
  default = "http://192.168.100.1:3128/"
}
variable "pool" {
  type = string
  default = "default"
}
variable "nb_vm" {
  type = number
  default = 1
}
variable "user" {
  type = string
  default = "ubuntu"
}
