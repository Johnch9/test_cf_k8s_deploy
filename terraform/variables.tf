#
# Variables Configuration
#

variable "client_id" {
    default = "7fa1224c-6542-4fbe-a4d6-a41b8838e743"
}
variable "client_secret" {}

variable "tenant_id" {
    default = "54bac2ae-1958-4010-81be-a981296d27cf"
}
variable "subscription_id" {
    default = "a5f5aa21-27ff-4096-a08a-f8ad35fa2624"
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
    default = "azcaptfCluster"
}

variable resource_group_name {
    default = "azcaptfRG"
}

variable location {
    default = "West Europe"
}
