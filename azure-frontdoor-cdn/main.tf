resource "azurerm_resource_group" "frontdoor-cdn-project" {
  name     = var.resource_group_name
  location = var.location

}


# ---------------------------------------------------------
# Azure Storage Account
# ---------------------------------------------------------

resource "azurerm_storage_account" "frontdoor-cdn-storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.frontdoor-cdn-project.name
  location                 = azurerm_resource_group.frontdoor-cdn-project.location
  account_tier              = "Standard"
  account_replication_type = "LRS"

  min_tls_version = "TLS1_2"

  static_website {
    index_document = "index.html"
    error_404_document = "index.html"
  }

}


# ---------------------------------------------------------
# Website HTML
# ---------------------------------------------------------

resource "azurerm_storage_blob" "website-blob" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.frontdoor-cdn-storage.name
  storage_container_name = "$web"

  type         = "Block"
  source       = "${path.module}/website/index.html"
  content_type = "text/html"
}


# ---------------------------------------------------------
# Azure Front Door Profile
# ---------------------------------------------------------

resource "azurerm_cdn_frontdoor_profile" "cdn" {
  name                = var.frontdoor_profile_name
  resource_group_name = azurerm_resource_group.frontdoor-cdn-project.name

  sku_name = "Standard_AzureFrontDoor"

}


# ---------------------------------------------------------
# Front Door Endpoint
# ---------------------------------------------------------

resource "azurerm_cdn_frontdoor_endpoint" "endpoint" {
  name                     = var.frontdoor_endpoint_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.cdn.id

  enabled = true
}


# ---------------------------------------------------------
# Front Door Origin Group
# ---------------------------------------------------------

resource "azurerm_cdn_frontdoor_origin_group" "front-group" {
  name                     = "storage-origin-group"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.cdn.id

  session_affinity_enabled = false

  health_probe {
    interval_in_seconds = 120
    path                = "/index.html"
    protocol            = "Https"
    request_type        = "HEAD"
  }

  load_balancing {
    additional_latency_in_milliseconds = 0
    sample_size                        = 4
    successful_samples_required        = 3
  }
}


# ---------------------------------------------------------
# Front Door Origin
# ---------------------------------------------------------

resource "azurerm_cdn_frontdoor_origin" "storage" {
  name                          = "storage-static-website"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.front-group.id

  enabled = true

  host_name          = azurerm_storage_account.frontdoor-cdn-storage.primary_web_host
  origin_host_header = azurerm_storage_account.frontdoor-cdn-storage.primary_web_host

  http_port  = 80
  https_port = 443

  certificate_name_check_enabled = true
}


# ---------------------------------------------------------
# Front Door Route
# ---------------------------------------------------------

resource "azurerm_cdn_frontdoor_route" "front-route" {
  name                          = "website-route"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.front-group.id

  cdn_frontdoor_origin_ids = [
    azurerm_cdn_frontdoor_origin.storage.id
  ]

  enabled = true

  patterns_to_match = [
    "/*"
  ]

  supported_protocols = [
    "Http",
    "Https"
  ]

  forwarding_protocol    = "HttpsOnly"
  https_redirect_enabled = true

  link_to_default_domain = true

  cache {
    compression_enabled = true

    content_types_to_compress = [
      "text/html",
      "text/css",
      "text/javascript",
      "application/javascript",
      "application/json",
      "image/svg+xml"
    ]

    query_string_caching_behavior = "IgnoreQueryString"
  }
}
