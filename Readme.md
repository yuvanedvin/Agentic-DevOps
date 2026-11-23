This Readme file gives brief introduction about the project's features and functionalities.

- The initial repository structure will be like below

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