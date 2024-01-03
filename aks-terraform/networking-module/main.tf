# networking-module/main.tf

resource "azurerm_resource_group" "azrg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "azvnet" {
  name                = "aks-vnet"
  location            = azurerm_resource_group.azrg.location
  resource_group_name = azurerm_resource_group.azrg.name
  address_space       = var.vnet_address_space
  
}
resource "azurerm_subnet" "control-plane-subnet" {
  name           = "control-plane-subnet"
  address_prefixes = ["10.0.1.0/24"]
  resource_group_name = azurerm_resource_group.azrg.name
  virtual_network_name = azurerm_virtual_network.azvnet.name
  }
resource "azurerm_subnet" "worker-node-subnet" {
  name           = "worker-node-subnet"
  address_prefixes = ["10.0.2.0/24"]
  resource_group_name = azurerm_resource_group.azrg.name
  virtual_network_name = azurerm_virtual_network.azvnet.name
  }
resource "azurerm_network_security_group" "aznsg" {
  name                = "aks-nsg"
  location            = azurerm_resource_group.azrg.location
  resource_group_name = azurerm_resource_group.azrg.name
}

resource "azurerm_network_security_rule" "azkuberule" {
  name                        = "kube-apiserver-rule"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "192.168.0.71"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.azrg.name
  network_security_group_name = azurerm_network_security_group.aznsg.name
}

resource "azurerm_network_security_rule" "azsshrule" {
  name                       = "ssh-rule"
  priority                   = 1002
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "22"
  source_address_prefix      = "192.168.0.71"
  destination_address_prefix = "*"
  resource_group_name         = azurerm_resource_group.azrg.name
  network_security_group_name = azurerm_network_security_group.aznsg.name
  }
