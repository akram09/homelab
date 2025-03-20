terraform {
  required_version = ">= 0.13"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.49.1"
    }
  }
}


variable "do_token" {
  description = "Digital Ocean Token"
  type = string
}


variable "do_homelab_ssh_key" {
  description = "SSH Key for Homelab"
  type = string
}



provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_ssh_key" "homelab" {
  name       = "homelab"
  public_key = file(var.do_homelab_ssh_key)
}

resource "digitalocean_volume" "kratos-volume" {
  region = "fra1"
  name = "kratos-volume"
  size = 100
  description = "Homelab Volume"
}

resource "digitalocean_droplet" "kratos" {
    image = "ubuntu-24-10-x64"
    name = "kratos"
    region = "fra1"
    size = "s-2vcpu-4gb"
    ssh_keys = [digitalocean_ssh_key.homelab.id]
    volume_ids = [digitalocean_volume.kratos-volume.id]
}


output "kratos_ip" {
  value = digitalocean_droplet.kratos.ipv4_address
}
