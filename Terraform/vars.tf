variable "resource_group" {
  type        = string
  default     = "movie_analyst"
  description = "Name of the resource group where is going to be deployed the project components"
}
variable "environment" {
  type        = string
  default     = "Test"
  description = "Working environment"
}
variable "location" {
  type        = string
  default     = "eastus"
  description = "Region where project is deployed"
}
variable "provision_vm_agent" {
  type        = bool
  default     = true
  description = "(optional) describe your variable"
}
variable "servers" {
  type        = list(string)
  default     = ["bastion-server", "movie-db-server"]
  description = "List of servers names"
}
variable "network" {
  type        = string
  default     = "10.0.0.0/16"
  description = "Network of my project"
}
variable "subnets" {
  type        = map(string)
  description = "List of subnets"
  default = {
    bastion-server = "10.0.16.0/20"
    db-server      = "10.0.64.0/20"
  }
}

# Export variable TF_VARS_*
variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}