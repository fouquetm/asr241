resource "azurerm_container_group" "hello-world" {
  name                = "ci-asr241-hello-world"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  ip_address_type     = "Public"
  dns_name_label      = "aci-asr241-teacher"
  os_type             = "Linux"

  exposed_port = [
    {
      port     = 8080
      protocol = "TCP"
    }
  ]

  container {
    name   = "hello-world"
    image  = "mcr.microsoft.com/dotnet/samples:aspnetapp"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 8080
      protocol = "TCP"
    }
  }

  tags = {
    environment = "testing"
  }
}
