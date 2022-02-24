resource "aws_ecs_cluster" "main_cluster" {
  name = "main-cluster"
}

resource "aws_ecs_cluster_capacity_providers" "main_cluster_capacity" {
  cluster_name = aws_ecs_cluster.main_cluster.name

  capacity_providers = ["FARGATE"]

}

resource "aws_ecs_task_definition" "web_task" {
  family                   = "web"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.task_cpu_units
  memory                   = var.task_memory

  container_definitions = jsonencode([
    {
      name      = var.task_name
      image     = var.container_image
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])

  runtime_platform {
    operating_system_family = var.os_family
    cpu_architecture        = null
  }
}

resource "aws_security_group" "web_service_sg" {
  name        = "fargate_web_service_sg"
  description = "Enable http access to the fargate hosted web service"
  vpc_id      = var.vpc_id
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }
}

resource "aws_ecs_service" "web_service" {
  name            = "web-service"
  cluster         = aws_ecs_cluster.main_cluster.id
  task_definition = aws_ecs_task_definition.web_task.arn
  desired_count   = var.task_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.service_subnets
    security_groups  = [aws_security_group.web_service_sg.id]
    assign_public_ip = true
  }
  # iam_role = role for lambda access
}