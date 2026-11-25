variable "name" {
  description = "Base name for VPC resources"
  type        = string
}

variable "vpc_cidr" {
  description = "IPv4 CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "Availability zones to use"
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) >= 2
    error_message = "The VPC requires at least two availability zones."
  }
}

variable "single_nat_gateway" {
  description = "Create a single shared NAT gateway"
  type        = bool
  default     = false
}
