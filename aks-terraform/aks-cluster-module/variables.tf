# aks-cluster-module/variables.tf

variable "aks_cluster_name" {
    description = "The name of the AKS cluster."
    type = string
    default = "azure_aks_cluster"
}

variable "cluster_location" {
    description = "The location of the Azure region where the AKS cluster will be deployed to."
    type = string
    default = "UK South"
}

variable "dns_prefix" {
    description = "The DNS prefix for the AKS cluster, which is used to create a unique DNS name for the cluster."
    type = string
}

variable "kubernetes_version" {
    description = "The Kubernetes version that the cluster will use."
    type = string
}

variable "service_principal_client_id" {
    description = "The Client ID of the service principal used for authenticating and managing the AKS cluster."
    type = string
}

variable "service_principal_client_secret" {
    description = "The Client Secret associated with the service principal used for AKS cluster authentication."
    type = string
}

# Input variables from the networking module

variable "resource_group_name" {
    description = "The name of the resource group that will hold the networking resources"
    type = string
  
}

variable "vnet_id" {
    description = "ID of the Virtual Network (VNet)."
    type = string 
}

variable "control_plane_subnet_id" {
    description = "ID of the control plane subnet."
    type = string
    
}

variable "worker_node_subnet_id" {
     description = "ID of the worker node subnet."
     type = string
     
  
}

variable "aks_nsg_id" {
     description = "ID of the Network Security Group (NSG)."
     type = string
     
}
