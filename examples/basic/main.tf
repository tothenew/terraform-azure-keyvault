provider "azurerm" {
  features {}
}

locals {
  env         = var.env
  name        = var.pname
  name_prefix = "${local.env}${local.name}"
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = "${local.name_prefix}-rg"
  location = var.location
}

module "log_analytics" {
  source = "git::https://github.com/tothenew/terraform-azure-loganalytics.git"

  workspace_name      = "${local.name_prefix}-log"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

module "key_vault" {
  # source = "git::https://github.com/tothenew/terraform-azure-keyvault.git"
  source = "../.."

  vault_name                 = "${local.name_prefix}-kv"
  resource_group_name        = azurerm_resource_group.rg.name
  location                   = azurerm_resource_group.rg.location
  log_analytics_workspace_id = module.log_analytics.workspace_id

  access_policies = [
    {
      object_id          = data.azurerm_client_config.current.object_id
      secret_permissions = ["Get", "List", "Set", "Delete", "Backup", "Restore", "Recover"]
    }
  ]
}