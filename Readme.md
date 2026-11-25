This Readme file gives brief introduction about the project's features and functionalities.

- The initial repository structure is organized as below:

Repo/
│
├── terraform/
│   ├── backend.tf
│   ├── provider.tf
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── modules/
│   │   ├── vpc/
│   │   └── iam/
│   └── environments/
│       └── dev/
│
├── application/
│   ├── src/
│   └── pom.xml
│
├── kubernetes/
│   ├── deployment.yaml
│   ├── service.yaml
│   └── hpa.yaml
│
├── .github/
│   └── workflows/
│       ├── terraform.yml
│       └── application-deploy.yml
│
├── monitoring/
│   ├── cloudwatch-alarms.tf
│   └── runbooks/
│
└── README.md

## AWS infrastructure

The Terraform configuration provisions:

- A highly available VPC with public and private subnets across three availability zones
- NAT gateways, VPC DNS, and VPC flow logs
- Least-privilege IAM roles for the EKS control plane and worker nodes
- Immutable, vulnerability-scanning ECR repositories
- An encrypted EKS cluster with managed nodes, private API access, control-plane logging, and an OIDC provider

### Initial setup

1. Configure AWS credentials and the target account.
2. Create the S3 bucket referenced by `terraform/backend.tf` for remote state.
3. From the `terraform/` directory, initialize and validate:

   ```bash
   terraform init
   terraform fmt -check -recursive
   terraform validate
   terraform plan
   ```

4. Review the plan before applying. Environments can override the defaults with a tfvars file.

The baseline is intentionally private-first: EKS API public access is disabled by default. Override `cluster_endpoint_public` and
`cluster_endpoint_public_cidrs` only after defining the approved network boundaries.