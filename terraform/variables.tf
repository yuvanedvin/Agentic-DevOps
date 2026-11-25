variable "aws_region" {
  description = "AWS region in which to provision infrastructure"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment name"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be dev, staging, or prod."
  }
}

variable "project" {
  description = "Project name used for resource naming and tags"
  type        = string
  default     = "agentic-devops"

  validation {
    condition     = can(regex("^[a-z0-9-]{3,32}$", var.project))
    error_message = "project must contain 3-32 lowercase letters, numbers, or hyphens."
  }
}

variable "vpc_cidr" {
  description = "IPv4 CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Availability zones used for the VPC and EKS cluster"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "single_nat_gateway" {
  description = "Use one NAT gateway instead of one per availability zone"
  type        = bool
  default     = false
}

variable "cluster_endpoint_public" {
  description = "Whether the EKS API endpoint is publicly reachable"
  type        = bool
  default     = false
}

variable "cluster_endpoint_public_cidrs" {
  description = "IPv4 CIDR blocks allowed to reach the public EKS API endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]

  validation {
    condition     = alltrue([for cidr in var.cluster_endpoint_public_cidrs : can(cidrhost(cidr, 0))])
    error_message = "cluster_endpoint_public_cidrs must contain valid IPv4 CIDR blocks."
  }
}

variable "ecr_repository_names" {
  description = "Names of application repositories to create in ECR"
  type        = list(string)
  default     = ["agentic-devops/application"]

  validation {
    condition     = length(var.ecr_repository_names) > 0
    error_message = "At least one ECR repository name is required."
  }
}

variable "node_instance_types" {
  description = "EC2 instance types for EKS managed nodes"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_desired_size" {
  description = "Desired number of EKS worker nodes"
  type        = number
  default     = 1
}

variable "node_min_size" {
  description = "Minimum number of EKS worker nodes"
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "Maximum number of EKS worker nodes"
  type        = number
  default     = 2
}

variable "cluster_kubernetes_version" {
  description = "EKS Kubernetes control plane version"
  type        = string
  default     = "1.32"
}