provider "azurerm" {
  version = "=2.0.0"
  skip_provider_registration = "true"
  features {}
}

resource "random_id" "server" {
  keepers = {
    azi_id = 1
  }
  byte_length = 8
}

variable "ComponentResourceGroupName" {
  type = string
}
 
data "azurerm_resource_group" "test" {
  name     = var.ComponentResourceGroupName
}

resource "azurerm_app_service_plan" "test" {
  name                = "some-app-service-plan"
  location            = data.azurerm_resource_group.test.location
  resource_group_name = data.azurerm_resource_group.test.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "test" {
  name                = random_id.server.hex
  location            = data.azurerm_resource_group.test.location
  resource_group_name = data.azurerm_resource_group.test.name
  app_service_plan_id = azurerm_app_service_plan.test.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}