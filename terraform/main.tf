terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = ">= 3.5.0"
    }
  }
}

provider "azurerm" {
    features {
    }
}

resource "azurerm_resource_group" "rg-activity-kubernetes" {
    location= "eastus"
    name = "rg-activity-kubernetes"
}

resource "azurerm_kubernetes_cluster" "aks-activity-kubernetes" {
    name = "aks-activity-kubernetes"
    location = azurerm_resource_group.rg-activity-kubernetes.location
    resource_group_name = azurerm_resource_group.rg-activity-kubernetes.name
    dns_prefix = "aks-activity-kubernetes"
    http_application_routing_enabled = true

    default_node_pool {
        name = "default"
        node_count = 3
        vm_size = "Standard_D2_v2"
    }

    identity {
        type = "SystemAssigned"
    }
}

