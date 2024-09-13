terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.63.0"
    }
    github = {
      source  = "integrations/github"
      version = "6.2.3"
    }
  }
  backend "azurerm" {

  }
}

provider "proxmox" {
  endpoint  = var.proxmox_endpoint
  api_token = var.proxmox_api_token
  insecure  = var.proxmox_tls_insecure
  ssh {
    private_key = var.ssh_private_key
    agent = true
    username    = "root"
  }
}

provider "github" {
  token = var.github_token
}
