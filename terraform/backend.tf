terraform {
  backend "s3" {
    bucket       = "terraform-infra-state-bucket-431684229532"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
