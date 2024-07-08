terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.53.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.76.0"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

provider "azuread" {
}