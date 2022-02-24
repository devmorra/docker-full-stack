variable "vpc_cidr_block" {
  description = "CIDR block for the vpc"
  default     = "10.0.0.0/16"
}

variable "pub_cidr_block" {
  description = "CIDR block for the public subnet"
  default     = "10.0.1.0/24"
}

variable "priv_cidr_block" {
  description = "CIDR block for the private subnet"
  default     = "10.0.2.0/24"
}