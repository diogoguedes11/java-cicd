# Java CI/CD Learning Tutorial

Welcome to this comprehensive tutorial on Java CI/CD with DevSecOps practices! This guide will help you understand and work with this repository step by step.

## 🎯 Learning Objectives

By completing this tutorial, you will:
- Understand CI/CD pipelines with GitHub Actions
- Learn DevSecOps security best practices
- Work with Docker containerization
- Deploy applications to Kubernetes
- Use GitOps with ArgoCD
- Implement infrastructure as code with Terraform
- Write and run unit tests for Spring Boot applications

## 📚 Prerequisites

- Basic knowledge of Java and Spring Boot
- Understanding of Git and GitHub
- Docker installed on your machine
- Maven installed (or use the Maven wrapper included)
- (Optional) kubectl and a Kubernetes cluster for deployment exercises

## 🏗️ Repository Structure

```
java-cicd/
├── app/                    # Spring Boot application
│   ├── src/
│   │   ├── main/java/      # Application source code
│   │   └── test/java/      # Unit tests
│   ├── Dockerfile          # Container image definition
│   └── pom.xml            # Maven dependencies and build config
├── .github/workflows/      # CI/CD pipelines
│   ├── app-deploy.yml     # Application deployment pipeline
│   └── infra-deploy.yml   # Infrastructure deployment pipeline
├── infra/                  # Terraform infrastructure code
│   ├── main.tf            # Main infrastructure definition
│   ├── aks.tf             # Azure Kubernetes Service config
│   └── ...
├── k8s/                    # Kubernetes manifests
│   ├── bootstrap/         # Initial K8s resources
│   └── gitops/            # ArgoCD application definitions
└── README.md
```

## 🚀 Getting Started

### Step 1: Clone and Explore

```bash
git clone https://github.com/diogoguedes11/java-cicd.git
cd java-cicd
```

Explore the repository structure:
```bash
# View the Spring Boot application
cat app/src/main/java/com/example/DemoApplication.java

# Check the Maven configuration
cat app/pom.xml

# Review the CI/CD pipeline
cat .github/workflows/app-deploy.yml
```

### Step 2: Build the Application

Navigate to the app directory and build:

```bash
cd app
mvn clean package
```

This command:
- Cleans previous builds
- Compiles the Java code
- Runs all tests
- Packages the application as a JAR file

### Step 3: Run Unit Tests

```bash
mvn test
```

The repository includes comprehensive tests:
- **Integration tests** (`DemoApplicationTests.java`): Test the full application context
- **Controller tests** (`ControllerTests.java`): Test individual REST endpoints

### Step 4: Run the Application Locally

```bash
mvn spring-boot:run
```

Once running, test the endpoints:
```bash
# Test the hello endpoint
curl http://localhost:8080/

# Test the health endpoint
curl http://localhost:8080/health

# Test the info endpoint
curl http://localhost:8080/info

# Check Prometheus metrics
curl http://localhost:8080/actuator/prometheus
```

Press `Ctrl+C` to stop the application.

### Step 5: Build and Run Docker Container

Build the Docker image:
```bash
docker build -t java-cicd-demo:latest .
```

Run the container:
```bash
docker run -p 8080:8080 java-cicd-demo:latest
```

Test it again with curl commands from Step 4.

## 🔒 DevSecOps Practices

This repository implements several security best practices:

### 1. Dependency Scanning
The CI/CD pipeline uses **Trivy** to scan for vulnerabilities:
```bash
# Install Trivy (if not already installed)
# On macOS: brew install trivy
# On Linux: Follow https://aquasecurity.github.io/trivy/

# Scan the filesystem for vulnerabilities
trivy fs app/
```

### 2. Container Image Scanning
Scan Docker images before deployment:
```bash
trivy image java-cicd-demo:latest
```

### 3. Security in CI/CD Pipeline
Review the GitHub Actions workflow (`.github/workflows/app-deploy.yml`):
- Trivy scans the codebase
- Security events are reported
- Images are scanned before pushing to registry

## 📝 Hands-On Exercises

### Exercise 1: Add a New Endpoint

**Goal**: Practice TDD (Test-Driven Development) by adding a new feature.

1. **Write the test first** (in `app/src/test/java/com/example/ControllerTests.java`):

```java
@Test
void testVersionController() throws Exception {
    mockMvc.perform(get("/version"))
            .andExpect(status().isOk())
            .andExpect(content().string("v0.1.0-SNAPSHOT"));
}
```

2. **Run the test** (it should fail):
```bash
cd app
mvn test
```

3. **Implement the feature** (in `app/src/main/java/com/example/DemoApplication.java`):

```java
@RestController
class VersionController {
  @GetMapping("/version")
  public String version() {
    AppLogger.logger.info("Version endpoint accessed");
    return "v0.1.0-SNAPSHOT";
  }
}
```

4. **Run the test again** (it should pass):
```bash
mvn test
```

### Exercise 2: Improve Test Coverage

Add more comprehensive tests:
- Test error scenarios
- Test with different input parameters
- Test edge cases

Example:
```java
@Test
void testRootEndpointReturnsNonEmptyString() throws Exception {
    mockMvc.perform(get("/"))
            .andExpect(status().isOk())
            .andExpect(content().string(not(emptyString())));
}
```

### Exercise 3: Customize the Application

Modify the application to make it your own:
1. Change the response messages
2. Add new endpoints (e.g., `/status`, `/api/users`)
3. Add request parameters to endpoints
4. Write tests for all changes

### Exercise 4: Understand the CI/CD Pipeline

1. Review `.github/workflows/app-deploy.yml`
2. Identify the different stages:
   - Checkout code
   - Setup Java
   - Build with Maven
   - Security scanning
   - Docker build and push

3. Try to answer:
   - What happens when a PR is created?
   - When does the Docker image get published?
   - What security checks are performed?

## 🐛 Troubleshooting

### Issue: Tests fail with connection errors to Loki

**Solution**: This is expected in local development. The application tries to connect to Loki for logging, but it's only available in the deployed environment. The tests still pass because the connection errors are handled gracefully.

### Issue: Maven build fails with "Java version mismatch"

**Solution**: Ensure you have Java 17 installed:
```bash
java -version
```

If not, install Java 17 or use a Docker container with Java 17.

### Issue: Port 8080 already in use

**Solution**: Stop any other applications using port 8080, or change the port:
```bash
mvn spring-boot:run -Dspring-boot.run.arguments=--server.port=8081
```

## 🎓 Advanced Topics

### GitOps with ArgoCD

The `k8s/` directory contains Kubernetes manifests and ArgoCD configurations for GitOps-based deployment.

**Key Concepts**:
- ArgoCD automatically syncs your Git repository with your Kubernetes cluster
- Changes to manifests in Git are automatically deployed
- Provides a web UI to visualize your applications

### Infrastructure as Code

The `infra/` directory contains Terraform code to provision:
- Azure Kubernetes Service (AKS)
- Azure Container Registry (ACR)
- ArgoCD installation
- Necessary IAM roles and permissions

**To deploy infrastructure**:
```bash
cd infra
terraform init
terraform plan
terraform apply
```

### Monitoring and Observability

The application is configured with:
- **Prometheus**: Metrics collection (exposed at `/actuator/prometheus`)
- **Loki**: Log aggregation
- **Spring Boot Actuator**: Health checks and operational endpoints

## 📖 Additional Resources

- [Spring Boot Documentation](https://spring.io/projects/spring-boot)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [ArgoCD Documentation](https://argo-cd.readthedocs.io/)
- [Terraform Documentation](https://www.terraform.io/docs/)

## 🤝 Contributing

Feel free to:
- Add more tests
- Improve documentation
- Add new features
- Report issues
- Submit pull requests

## 📝 Next Steps

1. ✅ Complete all hands-on exercises
2. ✅ Customize the application with your own features
3. ✅ Set up CI/CD for your own fork
4. ✅ Deploy to a Kubernetes cluster (optional)
5. ✅ Explore the infrastructure code

## 💡 Tips for Learning

- **Start small**: Understand each component before moving to the next
- **Experiment**: Try breaking things to understand how they work
- **Read the code**: The codebase is small and well-structured
- **Run locally first**: Test everything locally before pushing to CI/CD
- **Use the tests**: They're great examples of how the code should work

Happy learning! 🚀
