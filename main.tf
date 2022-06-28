provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = var.yc_region
}

module "yc_instance" {
  source = "./modules/instance/"
  instance_count = local.yc_instance_count[terraform.workspace]
  name           = "yc-instance"
  description    = "instance depends on workspace by count"
  folder_id      = module.vpc.folder_id
  zone           = var.yc_region

  cores          = local.yc_cores[terraform.workspace]
  memory         = local.yc_memory[terraform.workspace]
  core_fraction  = local.yc_core_fraction[terraform.workspace]

  disk_size      = local.yc_disk_size[terraform.workspace]
  subnet_id      = module.vpc.subnet_ids[0]

  users          = "ubuntu"

  depends_on = [
    module.vpc
  ]
}

//  instance_role  = "template"
//  boot_disk     = "network-ssd"

locals {
  yc_instance_count = {
    stage = 1
    prod  = 2
  }
  yc_cores = {
    stage = 2
    prod  = 4
  }
  yc_memory = {
    stage = 4
    prod  = 8
  }
  yc_core_fraction = {
    stage = 20
    prod  = 100
  }
  yc_disk_size = {
    stage = 20
    prod  = 40
  }
}