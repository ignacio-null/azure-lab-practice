output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "web_app_url" {
  value = azurerm_linux_web_app.app.default_hostname
}

output "cosmos_db_endpoint" {
  # Como DB es opcional (count), devolvemos el valor solo si se creó, sino un mensaje
  value = length(azurerm_cosmosdb_account.db) > 0 ? azurerm_cosmosdb_account.db[0].endpoint : "No Database Created"
}
