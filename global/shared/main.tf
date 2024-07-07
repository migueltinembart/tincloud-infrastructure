terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "4.36.0"
    }
  }
  backend "azurerm" {
    
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}