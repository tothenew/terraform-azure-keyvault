variable "vault_name" {
  description = "The name of this Key vault."
  type        = string
  default     = "vault-name"
}

variable "resource_group_name" {
  description = "The name of the resource group to create the resources in."
  type        = string
  default     = "rgname"
}

variable "location" {
  description = "The location to create the resources in."
  type        = string
  default     = "northeurope"
}

variable "soft_delete_retention_days" {
  description = "The number of days that items should be retained for once soft-deleted."
  type        = number
  default     = 90
}

variable "purge_protection_enabled" {
  description = "Is purge protection enabled for this Key vault?"
  type        = bool
  default     = false
}

variable "access_policies" {
  description = "A list of access policies for this Key vault."
  type = list(object({
    object_id               = string
    secret_permissions      = optional(list(string), [])
    certificate_permissions = optional(list(string), [])
    key_permissions         = optional(list(string), [])
  }))
  default = []
}

variable "enable_rbac_authorization" {
  description = "Should RBAC authorization be enabled for this Key vault?"
  type        = bool
  default     = false
}

variable "network_acls_bypass" {
  description = "Specifies which traffic can bypass the network rules for this Key vault. Possible values are AzureServices and None."
  type        = string
  default     = "AzureServices"
}

variable "network_acls_ip_rules" {
  description = "A list of IP addresses or CIDR blocks that should be able to bypass the network ACL and access this Key vault."
  type        = list(string)
  default     = []
}

variable "network_acls_virtual_network_subnet_ids" {
  description = "A list of Virtual Network subnet IDs that should be able to bypass the network ACL and access this Key vault."
  type        = list(string)
  default     = []
}

variable "diagnostic_setting_name" {
  description = "The name of this diagnostic setting."
  type        = string
  default     = "audit-logs"
}

variable "diagnostic_setting_enabled_log_categories" {
  description = "A list of log categories to be enabled for this diagnostic setting."
  type        = list(string)
  default     = ["AuditEvent"]
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace to send diagnostics to."
  type        = string
  default     = "log-analytics"
}

variable "log_analytics_destination_type" {
  description = "The type of log analytics destination to use for this Log Analytics Workspace."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}

variable "nacl_default_action" {
  description = "The default action of the Network ACL (NACL) attached to the Azure Key Vault. Allowed values are 'Allow' or 'Deny'."
  type        = string
  default     = "Deny"
}

variable "sku_name" {
  description = "The SKU (pricing tier) name for the Azure Key Vault. Valid values include 'standard' and 'premium'."
  type        = string
  default     = "standard"
}

variable "enabled_for_deployment" {
  description = "Specifies whether the Azure Key Vault is enabled for deployment. Set to 'true' to enable or 'false' to disable."
  type        = bool
  default     = false
}

variable "enabled_for_disk_encryption" {
  description = "Specifies whether the Azure Key Vault is enabled for disk encryption. Set to 'true' to enable or 'false' to disable."
  type        = bool
  default     = false
}

variable "enabled_for_template_deployment" {
  description = "Specifies whether the Azure Key Vault is enabled for template deployment. Set to 'true' to enable or 'false' to disable."
  type        = bool
  default     = false
}

variable "diagnostic_setting_enabled_metrics" {
  description = "A map of metrics categories and their settings to be enabled for this diagnostic setting."
  type = map(object({
    enabled           = bool
    retention_days    = number
    retention_enabled = bool
  }))
  default = {
    "AllMetrics" = {
      enabled           = true
      retention_days    = 0
      retention_enabled = false
    }
  }
}

variable "name" {
  type        = string
  description = "A string value to describe prefix of all the resources"
  default     = ""
}

variable "default_tags" {
  type        = map(string)
  description = "A map to add common tags to all the resources"
  default = {
    "Scope" : "ACI"
    "CreatedBy" : "Terraform"
  }
}

variable "common_tags" {
  type        = map(string)
  description = "A map to add common tags to all the resources"
  default     = {}
}