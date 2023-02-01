provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "myresourcegroup" {
  name     = "${var.prefix}-workshop"
  location = var.location

  tags = {
    environment = "Production"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  location            = azurerm_resource_group.myresourcegroup.location
  address_space       = [var.address_space]
  resource_group_name = azurerm_resource_group.myresourcegroup.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.prefix}-subnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.myresourcegroup.name
  address_prefixes     = [var.subnet_prefix]
}

resource "azurerm_network_security_group" "futureApp-sg" {
  name                = "${var.prefix}-sg"
  location            = var.location
  resource_group_name = azurerm_resource_group.myresourcegroup.name

  security_rule {
    name                       = "HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTPS"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "SSH"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "futureApp-nic" {
  name                      = "${var.prefix}-futureApp-nic"
  location                  = var.location
  resource_group_name       = azurerm_resource_group.myresourcegroup.name

  ip_configuration {
    name                          = "${var.prefix}ipconfig"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.futureApp-pip.id
  }
}

resource "azurerm_network_interface_security_group_association" "futureApp-nic-sg-ass" {
  network_interface_id      = azurerm_network_interface.futureApp-nic.id
  network_security_group_id = azurerm_network_security_group.futureApp-sg.id
}

resource "azurerm_public_ip" "futureApp-pip" {
  name                = "${var.prefix}-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.myresourcegroup.name
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.prefix}-future"
}

data "hcp_packer_image" "azure-ubuntu-apache" {
  bucket_name     = "azure-ubuntu-apache"
  channel         = "latest"
  cloud_provider  = "azure"
  region          = "Australia East"
}


resource "azurerm_linux_virtual_machine" "futureApp" {
  name                = "${var.prefix}-future"
  location            = var.location
  resource_group_name = azurerm_resource_group.myresourcegroup.name
  vm_size             = var.vm_size

  network_interface_ids         = [azurerm_network_interface.futureApp-nic.id]
  delete_os_disk_on_termination = "true"

  source_image_id = data.hcp_packer_image.azure_ubuntu_nginx.cloud_image_id

  os_disk {
    name              = "${var.prefix}-osdisk"
    managed_disk_type = "Standard_LRS"
    caching           = "ReadWrite"
  }

  os_profile {
    computer_name  = var.prefix
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {}

  # Added to allow destroy to work correctly.
  depends_on = [azurerm_network_interface_security_group_association.futureApp-nic-sg-ass]
}

# We're using a little trick here so we can run the provisioner without
# destroying the VM. Do not do this in production.

# If you need ongoing management (Day N) of your virtual machines a tool such
# as Chef or Puppet is a better choice. These tools track the state of
# individual files and can keep them in the correct configuration.

# Here we do the following steps:
# Sync everything in files/ to the remote VM.
# Set up some environment variables for our script.
# Add execute permissions to our scripts.
# Run the deploy_app.sh script.
resource "null_resource" "configure-future-app" {
  depends_on = [
    azurerm_virtual_machine.futureApp,
  ]

  # Terraform 0.11
  # triggers {
  #   build_number = "${timestamp()}"
  # }

  # Terraform 0.12
  triggers = {
    build_number = timestamp()
  }

  provisioner "file" {
    source      = "${path.module}/files/"
    destination = "/home/${var.admin_username}/"

    connection {
      type     = "ssh"
      user     = var.admin_username
      password = var.admin_password
      host     = azurerm_public_ip.futureApp-pip.fqdn
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt -y update",
      "sleep 15",
      "sudo apt -y update",
      "sudo apt -y install apache2",
      "sudo systemctl start apache2",
      "sudo chown -R ${var.admin_username}:${var.admin_username} /var/www/html",
      "chmod +x *.sh",
      "cd /var/www/html",
      "rm index.html",
      "git clone https://github.com/CloudbrokerAz/theFutureHasLanded.git .",
      "LOCATION=${var.location} PREFIX=${var.prefix} /home/${var.admin_username}/deploy_app.sh",
      "sudo apt-get remove certbot",
      "sudo snap install --classic certbot",
      "sudo ln -s /snap/bin/certbot /usr/bin/certbot",
      "sudo certbot --agree-tos --apache --renew-by-default --register-unsafely-without-email -d ${var.prefix}-future.${var.location}.cloudapp.azure.com",
      "sudo apt -y install cowsay",
      "cowsay FUTURE Mooooooooooo!",
    ]

    connection {
      type     = "ssh"
      user     = var.admin_username
      password = var.admin_password
      host     = azurerm_public_ip.futureApp-pip.fqdn
    }
  }
}
