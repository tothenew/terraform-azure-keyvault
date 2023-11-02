# Azure Key Vault Terraform Module

[![Lint Status](https://github.com/tothenew/terraform-aws-template/workflows/Lint/badge.svg)](https://github.com/tothenew/terraform-aws-template/actions)
[![LICENSE](https://img.shields.io/github/license/tothenew/terraform-aws-template)](https://github.com/tothenew/terraform-aws-template/blob/master/LICENSE)

This Terraform module deploys an Azure Key Vault with customizable access policies, network settings, and diagnostic settings.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [azurerm](#requirement\_terraform) | >= 3.39.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_monitor_diagnostic_setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_client_config](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data |

## Prerequisites

Before using this Terraform module, ensure that you have the following prerequisites:

1. **Azure Account**: You need an active Azure account to deploy the resources.
2. **Terraform**: Install Terraform on your local machine. You can download it from the [official Terraform website](https://www.terraform.io/downloads.html).
3. **Azure CLI**: Install the Azure CLI on your local machine. You can download it from the [Azure CLI website](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).

- Terraform version >= 1.3.0 is required.
- Azure provider version >= 3.39.0 is required.

## Configure Azure Provider

To configure the Azure provider, you need to set up the necessary Azure credentials. If you already have the Azure CLI installed and authenticated with Azure, Terraform will use the same credentials.

If you haven't authenticated with Azure, you can do so by running:

```bash
az login
```


## Clone the Repository

First, clone this repository to your local machine using the following command:

```bash
git clone <repository_url>
cd <repository_name>
```

## Initialize Terraform

Once you have cloned the repository, navigate to the module directory and initialize Terraform:

```bash
cd path/to/module_directory
terraform init
```

This will download the necessary plugins required for Terraform to work with Azure.

## Apply the Terraform Configuration

After configuring the input variables, you can apply the Terraform configuration to create the Azure Container Group:

```bash
terraform apply
```

Terraform will show you the changes that will be applied to the infrastructure. Type `yes` to confirm and apply the changes.

## Clean Up

To clean up the resources created by Terraform, you can use the `destroy` command:

```bash
terraform destroy
```

Terraform will show you the resources that will be destroyed. Type `yes` to confirm and destroy the resources.


## Inputs

| Name                                       | Description                                  | Type         | Default                        |
|--------------------------------------------|----------------------------------------------|--------------|--------------------------------|
| `vault_name`                               | The name of the Key Vault.                  | `string`     |                                |
| `resource_group_name`                      | The name of the resource group.             | `string`     |                                |
| `location`                                 | The location for the Key Vault.             | `string`     |                                |
| `soft_delete_retention_days`                | Retention days for soft-deleted items.     | `number`     | `90`                           |

## Outputs

| Name                                      | Description                                  | Type         |
|-------------------------------------------|----------------------------------------------|--------------|
| `vault_id`                                | The ID of the Key Vault.                    | `string`     |
| `vault_name`                              | The name of the Key Vault.                  | `string`     |
| `vault_uri`                               | The URI of the Key Vault.                   | `string`     |


## Example Usage

```hcl
module "key_vault" {
  source = "path/to/module"

  vault_name                = "mykeyvault"
  resource_group_name       = "myresourcegroup"
  location                  = "East US"
  soft_delete_retention_days = 60
  ... (other input variables)
}
```

## List of variables

| Variable Name                             | Description                                                      | Type            | Required | Default Value       |
|-------------------------------------------|------------------------------------------------------------------|-----------------|----------|---------------------|
| `vault_name`                              | Name of this Key vault.                                         | `string`        | Yes      |                     |
| `resource_group_name`                     | Name of the resource group to create the resources in.          | `string`        | Yes      |                     |
| `location`                                | Location to create the resources in.                            | `string`        | Yes      |                     |
| `soft_delete_retention_days`              | Number of days to retain items once soft-deleted.              | `number`        | Yes      |                     |
| `purge_protection_enabled`                | Enable purge protection for this Key vault?                    | `bool`          | No       | `false`             |
| `access_policies`                         | Access policies for this Key vault.                            | `list(object)`  | No       | `[]`                |
| `enable_rbac_authorization`               | Enable RBAC authorization for this Key vault?                  | `bool`          | No       | `false`             |
| `network_acls_bypass`                     | Traffic that can bypass network rules for this Key vault.      | `string`        | No       | `"AzureServices"`  |
| `network_acls_ip_rules`                   | List of IP addresses or CIDR blocks with access to Key vault. | `list(string)`  | No       | `[]`                |
| `network_acls_virtual_network_subnet_ids` | List of subnet IDs with access to Key vault.                   | `list(string)`  | No       | `[]`                |
| `enabled_for_deployment`                  | Is Key vault enabled for deployment?                           | `bool`          | No       | `false`             |
| `enabled_for_disk_encryption`             | Is Key vault enabled for disk encryption?                      | `bool`          | No       | `false`             |
| `enabled_for_template_deployment`         | Is Key vault enabled for template deployment?                  | `bool`          | No       | `false`             |
| `diagnostic_setting_name`                 | Name of this diagnostic setting.                               | `string`        | No       | `"audit-logs"`      |
| `diagnostic_setting_enabled_log_categories` | Enabled log categories for diagnostic setting.              | `list(string)`  | No       | See below           |
| `log_analytics_workspace_id`              | ID of the Log Analytics workspace for diagnostics.            | `string`        | No       | `"log-analytics"`   |
| `log_analytics_destination_type`          | Type of log analytics destination for this workspace.         | `string`        | No       | `null`              |
| `tags`                                    | Tags to assign to the resources.                               | `map(string)`   | No       |                     |
| `name`                                    | Prefix for all resource names.                                 | `string`        | No       | `""`                |
| `default_tags`                            | Common tags for all resources.                                 | `map(string)`   | No       | See below           |
| `common_tags`                             | Additional common tags for resources.                          | `map(string)`   | No       | `{}`                |
| `nacl_default_action`                     | Default action of Network ACL attached to Key vault.           | `string`        | No       | `"Deny"`            |
| `sku_name`                                | SKU name for the Key vault.                                    | `string`        | No       | `"standard"`        |
| `diagnostic_setting_enabled_metrics`       | Enabled metric categories for diagnostic setting.              | `map(object)`   | No       | See below           |
| `default_tags`                            | Common tags for all resources.                                 | `map(string)`   | No       | See below           |
| `common_tags`                             | Additional common tags for resources.                          | `map(string)`   | No       | `{}`                |

Default value for `diagnostic_setting_enabled_log_categories`:
```hcl
[
  "AuditEvent"
]
```

Default value for `default_tags`:
```hcl
{
  "Scope": "ACR",
  "CreatedBy": "Terraform"
}
```

Please note that the variables in the "Required" column that are marked "No" can be left empty if you don't want to provide a value for them.

## Authors

Module managed by [TO THE NEW Pvt. Ltd.](https://github.com/tothenew)

## License

Apache 2 Licensed. See [LICENSE](https://github.com/tothenew/terraform-aws-template/blob/main/LICENSE) for full details.