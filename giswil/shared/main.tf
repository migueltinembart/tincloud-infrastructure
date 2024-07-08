terraform {
  required_providers {
    maas = {
      source  = "canonical/maas"
      version = "2.3.0"
    }
    github = {
      source  = "integrations/github"
      version = "6.2.0"
    }
  }
  backend "azurerm" {}
}

provider "maas" {
  api_version = "2.0"
  api_url     = var.maas_api_url
  api_key     = var.maas_api_key
}

provider "github" {
  token = var.github_token
}
