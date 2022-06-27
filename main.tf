terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token #chave que vai fazer comunicação entre o plugin e a minha conta do cloud 
}

resource "digitalocean_kubernetes_cluster" "k8s_project_test"{ 
  name   = var.k8s_name
  region = var.region
  version = "1.22.8-do.1"

  node_pool {
    name       = "default"
    size       = "s-2vcpu-2gb"
    node_count = 3
  }
}

variable "do_token" {}
variable "k8s_name" {}
variable "region" {}