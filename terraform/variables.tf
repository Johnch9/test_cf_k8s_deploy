#
# Variables Configuration
#

variable "client_id" {
}
variable "client_secret" {
}

variable "tenant_id" {
}
variable "subscription_id" {
}

variable "ad_k8s_sp_client_id" {
}

variable "ad_k8s_sp_server_id" {
}

variable "ad_k8s_sp_server_secret" {
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
    default = "azTestDevCluster1"
}

variable resource_group_name {
    default = "azTestDevRG1"
}

variable location {
    default = "West Europe"
}

