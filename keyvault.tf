resource "azurerm_key_vault" "key_vault" {
  name                = var.vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  soft_delete_retention_days = var.soft_delete_retention_days
  purge_protection_enabled   = var.purge_protection_enabled

  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment

  access_policy             = local.access_policies
  enable_rbac_authorization = var.enable_rbac_authorization

  tags = merge(local.common_tags, tomap({
    "Name" : local.project_name_prefix
  }))

  network_acls {
    default_action             = var.nacl_default_action
    bypass                     = var.network_acls_bypass
    ip_rules                   = var.network_acls_ip_rules
    virtual_network_subnet_ids = var.network_acls_virtual_network_subnet_ids
  }
}

resource "azurerm_monitor_diagnostic_setting" "monitor" {
  name                           = var.diagnostic_setting_name
  target_resource_id             = azurerm_key_vault.key_vault.id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  log_analytics_destination_type = var.log_analytics_destination_type

  dynamic "enabled_log" {
    for_each = toset(var.diagnostic_setting_enabled_log_categories)

    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = var.diagnostic_setting_enabled_metrics

    content {
      category = metric.key
      enabled  = metric.value.enabled

      retention_policy {
        days    = metric.value.retention_days
        enabled = metric.value.retention_enabled
      }
    }
  }
}