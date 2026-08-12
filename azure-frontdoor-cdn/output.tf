output "resource_group_name" {
  description = "Resource Group name"
  value       = azurerm_resource_group.frontdoor-cdn-project.name
}

output "storage_website_url" {
  description = "Direct Storage Static Website URL"
  value       = azurerm_storage_account.frontdoor-cdn-storage.primary_web_endpoint
}

output "frontdoor_endpoint_hostname" {
  description = "Azure Front Door hostname"
  value       = azurerm_cdn_frontdoor_endpoint.endpoint.host_name
}

output "frontdoor_url" {
  description = "Website URL through Azure Front Door"
  value       = "https://${azurerm_cdn_frontdoor_endpoint.endpoint.host_name}"
}
