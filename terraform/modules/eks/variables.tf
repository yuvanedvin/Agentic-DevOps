variable "name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes control plane version"
  type        = string
  default     = "1.32"
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs used by the cluster"
  type        = list(string)
}

variable "cluster_role_arn" {
  description = "IAM role ARN for the EKS control plane"
  type        = string
}

variable "node_role_arn" {
  description = "IAM role ARN for EKS worker nodes"
  type        = string
}

variable "endpoint_private_access" {
  description = "Enable private EKS API endpoint access"
  type        = bool
  default     = true
}

variable "endpoint_public_access" {
  description = "Enable public EKS API endpoint access"
  type        = bool
  default     = false
}

variable "public_access_cidrs" {
  description = "CIDR ranges allowed to access the public endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "node_instance_types" {
  description = "EC2 instance types for managed worker nodes"
  type        = list(string)
}

variable "node_desired_size" {
  description = "Desired worker node count"
  type        = number
}

variable "node_min_size" {
  description = "Minimum worker node count"
  type        = number
}

variable "node_max_size" {
  description = "Maximum worker node count"
  type        = number
}
