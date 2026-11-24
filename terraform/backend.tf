terraform {
  backend "s3" {
    bucket       = "terraform-state-bucket-426550965942-us-east-1-an"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
