#
# Variables Configuration
#

variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {
}
variable "subscription_id" {
}

variable cluster_name {
}

variable resource_group_name {
}

variable location {
}

variable kube_config_path {
}

variable api_nsg {
    default = "apiNSG"
}
