variable "task_name" {
  default = "fargate-task"
}

variable "task_cpu_units" {
  # 1024 = 1 vCPU?
  default = 256
}

variable "task_memory" {
  # mibibytes
  default = 1024
}

variable "container_image" {
  default = "cmorra/fargate-test-web:latest"
}

variable "os_family" {
  default = "LINUX"
}

variable "task_count" {
  default = 1
}

