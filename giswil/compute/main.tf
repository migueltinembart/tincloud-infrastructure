terraform {
  required_providers {
    maas = {
      source = "maas/maas"
      version = "2.2.0"
    }
  }
}

provider "maas" {
  api_url  = var.maas_api_url
  api_key  = var.maas_api_key
  
}