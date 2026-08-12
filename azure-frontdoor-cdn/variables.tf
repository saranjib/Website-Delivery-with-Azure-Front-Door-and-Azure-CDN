variable "resource_group_name" {
  description = "Azure Resource Group name"
  type        = string
  default     = "rg-frontdoor-cdn-demo"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "Central India"
}

variable "storage_account_name" {
  description = "Globally unique Storage Account name"
  type        = string
  default     = "frontdoorcdnwebsite01"
}

variable "frontdoor_profile_name" {
  description = "Azure Front Door profile name"
  type        = string
  default     = "fd-cdn-demo"
}

variable "frontdoor_endpoint_name" {
  description = "Azure Front Door endpoint name"
  type        = string
  default     = "fd-cdn-endpoint"
}
