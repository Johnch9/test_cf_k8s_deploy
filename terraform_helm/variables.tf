#
# Variables Configuration
#

variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {
}
variable "subscription_id" {
}
# variable "subscription_id" {}
# variable "tenant_id" {}
# variable "certificate_authority_data" {}
# variable "client_certificate_data" {}
# variable "client_key_data" {}
# variable "token" {}
# variable "host" { 
#     default = "https://aztestdevc-aztestdevrg-595bd1-55ad7f6f.hcp.westeurope.azmk8s.io:443" 
# }

variable cluster_name {
    default = "azAKSTestDevCluster1"
}

variable resource_group_name {
    default = "azAKSTestDevRG1"
}

variable location {
    default = "West Europe"
}

variable api_rg {
    default = "apiRG"
}
variable api_nsg {
    default = "apiNSG"
}
