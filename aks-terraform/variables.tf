# variables.tf

variable "client_id" {
  description = "Access key for the provider"
  type        = string
  sensitive   = true
}

variable "client_secret" {
  description = "Secret key for the provider"
  type        = string
  sensitive   = true
}

variable "service_principal_client_id" {
  description = "Service principal client ID"
  type        = string
  sensitive   = true
}

variable "service_principal_client_secret" {
  description = "Secret key for the service principal"
  type        = string
  sensitive   = true
}