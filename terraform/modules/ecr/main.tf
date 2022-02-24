provider "docker" {
    host = "http://hub.docker.com"
}

data "docker_registry_image" "web" {
    name = var.docker_image_location
}

resource "aws_ecr_repository" "ecr_repo"{
    name = var.ecr_repository
}

