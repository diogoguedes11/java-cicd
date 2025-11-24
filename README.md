# Java CI/CD with Terraform Infrastructure

This project demonstrates a complete CI/CD pipeline for a Java Spring Boot application, containerized with Docker, and deployed using Terraform on Azure.

## Project Structure

```
├── app/                  # Java Spring Boot application
│   ├── Dockerfile        # Docker build file for the app
│   ├── pom.xml           # Maven build configuration
│   └── src/              # Application source code
├── infra/                # Infrastructure as Code (IaC) with Terraform
│   ├── main.tf           # Main Terraform configuration
│   ├── provider.tf       # Provider and backend config
│   ├── variables.tf      # Input variables
│   └── outputs.tf        # Output values
├── .github/workflows/    # GitHub Actions workflows
│   ├── maven.yml         # Java build, test, and Docker publish pipeline
│   └── infra-deploy.yml  # Terraform infrastructure deployment pipeline
└── README.md             # Project documentation
```

## Features
- **Java 17** Spring Boot application
- **Maven** build and test automation
- **Docker** containerization and publishing to GitHub Container Registry
- **Terraform** for Azure infrastructure provisioning
- **GitHub Actions** for CI/CD automation

## Prerequisites
- [Java 17+](https://adoptium.net/)
- [Maven](https://maven.apache.org/)
- [Docker](https://www.docker.com/)
- [Terraform](https://www.terraform.io/)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- Azure subscription with permissions to create resources

## CI/CD Pipelines

### 1. Java Build & Publish (`.github/workflows/maven.yml`)
- Checks out code
- Builds and tests with Maven
- Packages the app
- Builds and pushes Docker image to GitHub Container Registry

### 2. Infrastructure Deploy (`.github/workflows/infra-deploy.yml`)
- Initializes Terraform
- Applies infrastructure changes to Azure
- Uses remote state backend (Azure Storage Account)

## Infrastructure Setup

Terraform uses a remote backend for state management. Ensure the following Azure resources exist:
- Resource Group: `rg-terraform-state`
- Storage Account: `tfstatestorageacct423921`
- Blob Container: `tfstate`

If not, create them with:
```bash
az group create --name rg-terraform-state --location westeurope
az storage account create --name tfstatestorageacct423921 --resource-group rg-terraform-state --location westeurope --sku Standard_LRS --encryption-services blob
az storage container create --name tfstate --account-name tfstatestorageacct423921
```

## Local Development

1. **Build the app:**
	```bash
	cd app
	mvn clean package
	```
2. **Run locally:**
	```bash
	java -jar target/*.jar
	```
3. **Build Docker image:**
	```bash
	docker build -t java-cicd-demo:latest .
	```

## Deploy Infrastructure

1. **Initialize Terraform:**
	```bash
	cd infra
	terraform init
	```
2. **Plan and apply:**
	```bash
	terraform plan
	terraform apply
	```

## GitHub Actions Secrets
- `AZURE_CREDENTIALS`: Service principal credentials for Terraform
- `GITHUB_TOKEN`: For Docker image push

## License

MIT License
