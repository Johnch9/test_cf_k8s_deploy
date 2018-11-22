# resource "azurerm_azuread_application" "k8s_ad_app" {
#   name                       = "${var.cluster_name}"
# }

# resource "azurerm_azuread_service_principal" "k8s_ad_app" {
#   application_id = "${azurerm_azuread_application.k8s_ad_app.application_id}"
# }

# resource "azurerm_azuread_service_principal_password" "k8s_ad_app" {
#   service_principal_id = "${azurerm_azuread_service_principal.k8s_ad_app.id}"
#   value                = "${var.ad_k8s_sp_pass}"
#   end_date             = "2020-01-01T01:02:03Z"
# }