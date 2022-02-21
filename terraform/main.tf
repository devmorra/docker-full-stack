terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.16.0"
    }
  }
}

provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region     = "${var.region}"
}

provider "docker" {
    host = "http://hub.docker.com"
}

data "docker_registry_image" "web" {
    name = "cmorra/fargate-test-web:latest"
}

output "docker-image" {
    value = data.docker_registry_image.web.id
}