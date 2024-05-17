variable "vpc_cidr" {
  type        = string
  description = "Cidr_block value of vpc"
  default     = "10.0.0.0/16"
}

variable "pub_sub_cidr" {
  type        = string
  description = "Cidr_block of public subnet"
  default     = "10.0.1.0/24"
}

variable "priv_sub_cidr" {
  type        = string
  description = "Cidr_block of private subnet"
  default     = "10.0.2.0/24"
}

variable "az" {
  type        = list(string)
  description = "Availability Zones in Region"
  default     = ["us-east-1a", "us-east-1b"]
}

variable "default_gateway" {
  type        = string
  description = "Gateway for access to the internet"
  default     = "0.0.0.0/0"
}
