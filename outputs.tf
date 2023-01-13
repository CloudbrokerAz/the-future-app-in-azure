output "futureApp_url" {
  value = "http://${azurerm_public_ip.futureApp-pip.fqdn}"
}

output "futureApp_ip" {
  value = "http://${azurerm_public_ip.futureApp-pip.ip_address}"
}
