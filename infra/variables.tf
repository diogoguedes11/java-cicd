variable "location" {
  description = "The Azure region to deploy resources in"
  type        = string
  default     = "West Europe"
}

variable "resource_group_name" {
  description = "The resource group name"
  type        = string
  default     = "rg-java-cicd"
}


variable "environment" {
  description = "The environment tag for resources"
  type        = string
  default     = "Production"
}

