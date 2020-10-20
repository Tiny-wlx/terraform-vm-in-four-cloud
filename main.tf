# alicloud
provider "alicloud" {
  region = "cn-shanghai"
}

resource "alicloud_instance" "ecs-poc" {
 image_id = "m-uf68h4rkl1g4f3ztdqyp"
 instance_type = "ecs.t5-lc2m1.nano"
 security_groups = ["sg-uf6b0hrl436l477s7tn4"]
 vswitch_id = "vsw-uf6pi8i2qxp15k58jonz6"
 private_ip = "172.19.112.191"
}


# aws
provider "aws" {
  region = "cn-north-1"
}

resource "aws_instance" "ec2-poc" {
 ami = "ami-0aec3e46a106ca42d"
 instance_type = "t2.micro"
 tags = {
   Name = "ec2-poc"
 }

 subnet_id = "subnet-0bd4eaf42e61566cd"

 private_ip = "10.102.0.191"

 security_groups = ["sg-0d52fb6abd6f76a51"]
 key_name = "aws-fortinet"
 associate_public_ip_address = true
}

// # azure
// provider "azurerm"{}

// variable "prefix" {
//  default = "poc"
// }

// locals {
//  location = "China North 2"
//  resource_group_name = "gdsdev"
// }

// data "azurerm_subnet" "subnet" {
//  name = "vm-subnet"
//  resource_group_name = local.resource_group_name
//  virtual_network_name = "gdsdev-vnet"
// }

// resource "azurerm_network_interface" "main" {
//  name                = "${var.prefix}-nic"
//  location            = local.location
//  resource_group_name = local.resource_group_name

//  ip_configuration {
//    name                          = "ipconfig"
//    subnet_id                     = data.azurerm_subnet.subnet.id
//    private_ip_address_allocation = "Static"
//    private_ip_address = "10.0.1.191"
//  }
// }

// resource "azurerm_virtual_machine" "main" {
//  name                  = "${var.prefix}-vm"
//  location              = local.location
//  resource_group_name   = local.resource_group_name
//  network_interface_ids = [azurerm_network_interface.main.id]
//  vm_size               = "Standard_DS1_v2"

//  # Uncomment this line to delete the OS disk automatically when deleting the VM
//  delete_os_disk_on_termination = true

//  # Uncomment this line to delete the data disks automatically when deleting the VM
//  delete_data_disks_on_termination = true

//  storage_image_reference {
//    publisher = "Canonical"
//    offer     = "UbuntuServer"
//    sku       = "16.04-LTS"
//    version   = "latest"
//  }
//  storage_os_disk {
//    name              = "myosdisk1"
//    caching           = "ReadWrite"
//    create_option     = "FromImage"
//    managed_disk_type = "Standard_LRS"
//  }
//  os_profile {
//    computer_name  = "hostname"
//    admin_username = "testadmin"
//    admin_password = "Password1234!"
//  }
//  os_profile_linux_config {
//    disable_password_authentication = false
//  }
//  tags = {
//    name = "azure-poc"
//  }
// }

//resource "azurerm_network_interface_security_group_association" "sg_association" {
//  network_interface_id      = azurerm_network_interface.main.id
//  network_security_group_id = [data.azurerm_network_security_group.sg.id]
//}
//
//data "azurerm_network_security_group" "sg" {
//  name                = "gdsdev-nsg"
//  resource_group_name = "gdsdev"
//}

# huawei
provider "huaweicloud" {
  region = "cn-east-2"
}

// data "huaweicloud_images_image_v2" "default" {
//  name        = "Ubuntu 18.04 server 64bit"
//  visibility  = "public"
//  most_recent = true
// }

// resource "huaweicloud_networking_port_v2" "port" {
//  network_id = "4c50ca74-0a8a-495b-b7d5-4c59d26a2f59"
//  fixed_ip {
//    subnet_id = "b83877ff-d64f-443c-b983-9aed0dff4ba2" # subnet-gdsdev
//    ip_address = "10.203.0.191"
//  }
// }

resource "huaweicloud_compute_instance_v2" "instance-poc" {
 availability_zone = "cn-east-2a"
 name = "instance-poc"
//  image_id = data.huaweicloud_images_image_v2.default.id
 image_id = "ff61492a-64fd-4783-bfc6-b7db0543ce70"
 flavor_name = "s3.small.1"
 network {
  //  port = huaweicloud_networking_port_v2.port.id
  uuid = "b83877ff-d64f-443c-b983-9aed0dff4ba2"
 }
 security_groups   = ["sg-ce93"]
}

# tencent
provider "tencentcloud" {
  region = "ap-shanghai"
}

// data "tencentcloud_images" "default" {
//  image_type = ["PUBLIC_IMAGE"]
//  os_name = "centos"
// }

data "tencentcloud_availability_zones" "default" {}

resource "tencentcloud_instance" "instance-poc" {
//  availability_zone = data.tencentcloud_availability_zones.default.zones.0.name
 availability_zone = "ap-shanghai-2"
//  image_id = data.tencentcloud_images.default.images.0.image_id
 image_id = "img-pi0ii46r"
 instance_type = "SA2.SMALL1"
 security_groups            = ["sg-awbhdtwi"]
 system_disk_type           = "CLOUD_PREMIUM"
 system_disk_size           = 50
 vpc_id                     = "vpc-gjkfx3fq"
 subnet_id                  = "subnet-qit2cxof"
 private_ip                 = "10.202.1.191"
}
