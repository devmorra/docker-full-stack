terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.16.0"
    }
  }
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.region
}



module "network_stack" {
  source = "./modules/networking"
}

module "fargate" {
  source          = "./modules/fargate"
  vpc_id          = module.network_stack.vpc_id
  service_subnets = [module.network_stack.public_subnet_id]
}