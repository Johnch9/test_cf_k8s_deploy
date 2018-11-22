resource "azurerm_kubernetes_cluster" "k8s" {
#    depends_on = ["azurerm_azuread_service_principal_password.k8s_ad_app"]
    name                = "${var.cluster_name}"
    location            = "${azurerm_resource_group.k8s.location}"
    resource_group_name = "${azurerm_resource_group.k8s.name}"
    dns_prefix          = "${var.dns_prefix}"

    # linux_profile {
    #     admin_username = "ubuntu"

    #     ssh_key {
    #     key_data = "${file("${var.ssh_public_key}")}"
    #     }
    # }

    agent_pool_profile {
        name            = "default"
        count           = "${var.agent_count}"
        vm_size         = "Standard_DS2_v2"
        os_type         = "Linux"
        os_disk_size_gb = 30
    }

    service_principal {
        client_id     = "${var.client_id}"
        client_secret = "${var.client_secret}"
    }

    role_based_access_control {
        azure_active_directory {
            client_app_id     = "${var.ad_k8s_sp_client_id}"
            server_app_id = "${var.ad_k8s_sp_server_id}"
            server_app_secret = "${var.ad_k8s_sp_server_secret}"
        }
    }

    tags {
        Environment = "Development"
    }
}