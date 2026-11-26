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

## Spring Boot application

The sample service is in `application/`. It exposes `GET /api/hello` and Spring Boot Actuator liveness/readiness endpoints.

Run locally with Java 21 and Maven:

```bash
cd application
mvn spring-boot:run
curl 'http://localhost:8080/api/hello?name=AWS'
```

Build a container image from the repository root:

```bash
docker build -t agentic-devops-app:local ./application
docker run --rm -p 8080:8080 agentic-devops-app:local
```

For EKS, push the image to the ECR repository created by Terraform, replace the sample image in
`kubernetes/deployment.yaml` with its ECR URL and tag, then apply the manifests:

```bash
kubectl apply -f kubernetes/deployment.yaml -f kubernetes/service.yaml
kubectl port-forward service/agentic-devops-app 8080:80
```

The service is internal (`ClusterIP`); use port-forwarding for a quick check, or add an ingress/load balancer for external access.
The deployment includes readiness and liveness probes so Kubernetes only routes traffic to healthy application pods.

### AWS DevOps Agent in this setup

AWS DevOps Agent is an operational and release-readiness assistant, not a component that runs inside the Spring Boot application.
Connect it to the AWS environment and the team's source repository, CI/CD system, and observability tools. It can use deployment
context and telemetry (for example, CloudWatch logs, metrics, and alarms) to investigate incidents, correlate failures with releases,
and recommend mitigations or resilience improvements. Its release-management capabilities can review changes and test them in a
configured verification environment. The application deployment workflow still needs to be implemented; once configured, GitHub
Actions can build, publish, and deploy the image while the agent adds analysis and operational support around that workflow.