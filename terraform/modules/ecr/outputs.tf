output "repository_urls" {
  description = "Map of repository names to repository URLs"
  value = {
    for name, repository in aws_ecr_repository.this :
    name => repository.repository_url
  }
}
