#
# Variables Configuration
#

variable "client_id" {
}
variable "client_secret" {}

variable "tenant_id" {
}
variable "subscription_id" {
}
variable "agent_count" {
    default = 1
}

variable "ssh_public_key" {
    default = "~/.ssh/id_rsa.pub"
}

variable "dns_prefix" {
    default = "k8stest"
}

variable cluster_name {
    default = "azTestDevCluster"
}

variable resource_group_name {
    default = "azTestDevRG"
}

variable location {
    default = "West Europe"
}
