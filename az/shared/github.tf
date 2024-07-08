data "azurerm_subscription" "top-level" {
  for_each = toset(var.subscription_ids)
  subscription_id = each.value
}

data "azuread_user" "owner" {
  user_principal_name = var.owner
}

resource "azuread_application" "github" {
  display_name            = "sp-github-shared"
  description             = "Service Principal for Github"
  owners                  = [data.azuread_user.owner.object_id]
  prevent_duplicate_names = true
}

resource "azuread_service_principal" "github" {
  account_enabled = true
  client_id       = azuread_application.github.client_id
  tags            = ["github"]
  owners          = [data.azuread_user.owner.object_id]
}

resource "azurerm_role_assignment" "github" {
    for_each = data.azurerm_subscription.top-level
    principal_id = azuread_service_principal.github.object_id
    scope = each.value.id
    role_definition_name = "Contributor"
}