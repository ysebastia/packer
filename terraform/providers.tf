terraform {
  required_version = ">= 0.12"
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.7.1"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.0"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}
