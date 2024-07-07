terraform {
  required_providers {
    maas = {
      source = "maas/maas"
      version = "2.2.0"
    }
    github = {
      source = "integrations/github"
      version = "6.2.0"
    }
  }
backend "azurerm" {}
}

provider "maas" {
  api_url  = var.maas_api_url
  api_key  = var.maas_api_key
  
}

provider "github" {
  token = var.github_token
  
}