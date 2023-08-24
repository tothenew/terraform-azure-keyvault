output "vault_id" {
  description = "The ID of this Key vault."
  value       = azurerm_key_vault.key_vault.id
}

output "vault_name" {
  description = "The name of this Key vault."
  value       = azurerm_key_vault.key_vault.name
}

output "vault_uri" {
  description = "The URI of this Key vault."
  value       = azurerm_key_vault.key_vault.vault_uri
}