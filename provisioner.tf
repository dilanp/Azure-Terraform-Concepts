
# Configuration.
terraform {
  required_version = "~> 1.1.0"
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = ">= 3.0"
    }
  }
}

resource "null_resource" "null_copy_ssk_key_to_bastion" {
  # Should only run after Bastion Linux VM has been created.
  depends_on = [azurerm_linux_virtual_machine.bastionlinuxvm]

  # Connection Block for Provisioners to connect to Azure VM Instance
  connection {
    type        = "ssh"
    host        = azurerm_linux_virtual_machine.bastionlinuxvm.public_ip_address
    user        = azurerm_linux_virtual_machine.bastionlinuxvm.admin_username
    private_key = file("${path.module}/ssh-keys/terraform-azure.pem")
  }

  ## File Provisioner
  ## Copies the terraform-key.pem file to /tmp/terraform-key.pem.
  provisioner "file" {
    source      = "ssh-keys/terraform-azure.pem"
    destination = "/tmp/terraform-azure.pem"
    #on_failure = continue
    #when = destroy
  }

  ## Remote Exec Provisioner
  ## Using remote-exec provisioner fix the private key permissions on Bastion Host.
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/terraform-azure.pem"
    ]
    #script = file(...)
  }
}

#========================================================================

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.40.0"
    }
  }
}

provider "azurerm" {
  features {}
}


resource "azurerm_container_registry" "acr-dev" {
  name                = "acrdevregistrycloudacademylab001"
  resource_group_name = "cal-1471-12"
  location            = "West US"
  sku                 = "Standard"
  admin_enabled       = false

  provisioner "local-exec" {
    when    = destroy # Redundant step just to demonstrate.
    command = <<EOT
       az acr repository delete --name ${self.name} --image hello-world:calab --yes
    EOT
  }
}

#Import Container Image to Azure Container Registries
resource "null_resource" "image" {

  provisioner "local-exec" {
    command = <<-EOT
       az acr import --name ${azurerm_container_registry.acr-dev.name} --source docker.io/library/hello-world:latest --image hello-world:calab
    EOT
  }
}
