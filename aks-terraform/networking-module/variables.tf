# networking-module/variables.tf

variable "resource_group_name" {
    description = "The name of the resource group that will hold the networking resources"
    type = string
    default = "webapp-rg"
}

variable "location" {
    description = "The name of the resource group that will hold the networking resources"
    type = string
    default = "UK South"
}

variable "vnet_address_space" {
    description = "The address space for the Virtual Network(VNet)"
    type = list(string)
    default = ["10.0.0.0/16"]
}

