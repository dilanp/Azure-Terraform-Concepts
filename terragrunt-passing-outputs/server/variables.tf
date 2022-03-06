variable "rg_location" {
  type        = string
  description = "Azure location of network components"
  default     = "westus2"
}

variable "rg_name" {
    type = string
    description = "Name of the Resource Group to deploy the Virtual Machine"
}

variable "subnet_id" {
    type = string
    description = "ID of the subnet to assign to the Network Interface resource"
}