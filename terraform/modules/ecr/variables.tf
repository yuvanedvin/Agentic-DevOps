variable "repository_names" {
  description = "Application repository names to create"
  type        = list(string)

  validation {
    condition     = length(var.repository_names) > 0
    error_message = "At least one ECR repository name is required."
  }
}
