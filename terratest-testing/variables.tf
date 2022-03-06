variable "servername" {
  type        = string
  description = "Name of the Virtual Machine"
}

variable "location" {
  type        = string
  description = "Azure location of network components"
  default     = "westus2"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the Resource Group to deploy the Virtual Machine"
}

variable "vm_size" {
  type        = string
  description = "Size of VM"
  default     = "Standard_B1s"
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet to assign to the Network Interface resource"
}