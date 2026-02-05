# Java CI/CD Pipeline with DevSecOps

This project demonstrates a secure CI/CD pipeline for a Java application, integrating DevSecOps best practices.

## 📚 Learning Resources

**New to this repository? Start here:**
- 📖 **[TUTORIAL.md](TUTORIAL.md)** - Comprehensive step-by-step tutorial for learning Java CI/CD
- 🎯 **[EXERCISES.md](EXERCISES.md)** - Hands-on exercises and challenges to practice your skills

## Table of Contents

- [Overview](#overview)
- [Pipeline Structure](#pipeline-structure)
- [DevSecOps Practices](#devsecops-practices)
- [Getting Started](#getting-started)
- [Learning Path](#learning-path)
- [Contributing](#contributing)
- [License](#license)

## Overview

This repository provides an example of a Java application with a CI/CD pipeline that incorporates security at every stage (DevSecOps). The pipeline automates building, testing, security scanning, and deployment.

## Pipeline Structure

1. **Source Control**: Code is managed in GitHub.
2. **Build**: Uses Maven/Gradle to compile and package the application.
3. **Test**: Runs unit and integration tests.
4. **Security Scanning**:
  - Static code analysis (e.g., SonarQube, SpotBugs)
  - Dependency vulnerability scanning (e.g., OWASP Dependency-Check)
5. **Containerization**: Builds Docker images.
6. **Image Scanning**: Scans Docker images for vulnerabilities (e.g., Trivy).
7. **Deployment**: Deploys to staging/production environments.
8. **Monitoring**: Integrates with monitoring and alerting tools.

## DevSecOps Practices

- Automated security checks in the pipeline.
- Dependency and container vulnerability scanning.
- Code quality and static analysis.
- Secrets management (never commit secrets to source control).
- Least privilege for pipeline credentials.

## Getting Started

### Quick Start (5 minutes)

1. **Clone the repository**:
   ```sh
   git clone https://github.com/diogoguedes11/java-cicd.git
   cd java-cicd
   ```

2. **Build and test**:
   ```sh
   cd app
   mvn clean package
   ```

3. **Run the application**:
   ```sh
   mvn spring-boot:run
   ```

4. **Test the endpoints**:
   ```sh
   curl http://localhost:8080/
   curl http://localhost:8080/health
   ```

### For Learners

📖 **Follow the [TUTORIAL.md](TUTORIAL.md)** for a complete learning path covering:
- Building and testing Java applications
- Docker containerization
- CI/CD pipelines with GitHub Actions
- DevSecOps security practices
- Kubernetes deployment
- Infrastructure as Code with Terraform

🎯 **Try the [EXERCISES.md](EXERCISES.md)** for hands-on practice with:
- REST API development
- Test-Driven Development (TDD)
- Container security
- Pipeline optimization
- And more!

### For Developers

1. **Build the project**:
   ```sh
   cd app
   mvn clean package
   ```

2. **Run tests**:
   ```sh
   mvn test
   ```

3. **Run security scans**:
   ```sh
   # Filesystem scan
   trivy fs app/
   ```

4. **Build Docker image**:
   ```sh
   cd app
   docker build -t java-cicd-demo:latest .
   ```

5. **Scan Docker image**:
   ```sh
   trivy image java-cicd-demo:latest
   ```

## Learning Path

1. ✅ **Start Here**: Read the [TUTORIAL.md](TUTORIAL.md)
2. ✅ **Practice**: Complete exercises in [EXERCISES.md](EXERCISES.md)
3. ✅ **Build**: Customize the application with your own features
4. ✅ **Deploy**: Set up your own CI/CD pipeline
5. ✅ **Advanced**: Explore Kubernetes and infrastructure code

## Contributing

Contributions are welcome! Please open issues or submit pull requests.

## License

This project is licensed under the MIT License.