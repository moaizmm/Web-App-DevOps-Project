# aks-terraform/main.tf
# Defines the main configuration file.

terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "=3.0.0"
        }
    }
}

provider "azurerm" {
    features {}
    client_id = "76381d54-3012-40c4-8fab-1cb463c5710d"
    client_secret = "9L28Q~ff_hOzDRvWvG-HBiaaMLhLBvDvLHqoUarT"
    subscription_id = "dd0193e8-693f-49c9-b1fe-4dddb252d5fd"
    tenant_id = "47321573-a048-466c-96f2-e79849a2a548"

}

module "networking" {
    source = "./networking-module"

    # Input variables for the networking module
    resource_group_name = "networking-resource-group"
    location = "UK South"
    vnet_address_space = ["10.0.0.0/16"]

}

module "aks_cluster" {
    source = "./aks-cluster-module"
    # Input variables for the AKS cluster module
    aks_cluster_name = "terraform-aks-cluster"
    cluster_location = "UK South"
    dns_prefix = "myaks-project"
    kubernetes_version = "1.26.6"
    service_principal_client_id = "76381d54-3012-40c4-8fab-1cb463c5710d"
    service_principal_secret = "9L28Q~ff_hOzDRvWvG-HBiaaMLhLBvDvLHqoUarT"

    # Input variables referencing outputs from the networking module
    resource_group_name = module.networking.networking_resource_group_name
    vnet_id = module.networking.vnet_id
    control_plane_subnet_id = module.networking.control_plane_subnet_id
    worker_node_subnet_id = module.networking.worker_node_subnet_id
    aks_nsg_id = module.networking.aks_nsg_id

}
