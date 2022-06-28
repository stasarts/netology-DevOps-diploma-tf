module "vpc" {
  source  = "hamnsk/vpc/yandex"
  version = "0.5.0"
  description = "managed by terraform"
  create_folder = length(var.yc_folder_id) > 0 ? false : true
  yc_folder_id = var.yc_folder_id
  name = terraform.workspace
  subnets = local.vpc_subnets[terraform.workspace]
}


locals {
  vpc_subnets = {
    stage = [
      {
        "v4_cidr_blocks": [
          "10.128.0.0/24"
        ],
        "zone": var.yc_region
      }
    ]
    prod = [
      {
        zone           = "ru-central1-a"
        v4_cidr_blocks = ["10.128.0.0/24"]
      },
      {
        zone           = "ru-central1-b"
        v4_cidr_blocks = ["10.129.0.0/24"]
      },
      {
        zone           = "ru-central1-c"
        v4_cidr_blocks = ["10.130.0.0/24"]
      }
    ]
  }
}
