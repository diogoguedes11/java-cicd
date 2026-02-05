# Practical Exercises for Java CI/CD Learning

This document contains hands-on exercises to help you master the concepts in this repository.

## 🎯 Exercise Track 1: Application Development

### Exercise 1.1: Basic REST API Extension
**Difficulty**: Beginner  
**Time**: 15-20 minutes

**Objective**: Add a new REST endpoint that returns JSON data.

**Tasks**:
1. Create a new controller class `UserController`
2. Add a GET endpoint at `/api/users` that returns a list of users
3. Return JSON format (Spring Boot handles this automatically)
4. Write unit tests for the new endpoint

**Sample Implementation**:
```java
@RestController
class UserController {
    @GetMapping("/api/users")
    public List<String> getUsers() {
        AppLogger.logger.info("Users endpoint accessed");
        return Arrays.asList("Alice", "Bob", "Charlie");
    }
}
```

**Test Example**:
```java
@Test
void testUserController() throws Exception {
    mockMvc.perform(get("/api/users"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$").isArray())
            .andExpect(jsonPath("$[0]").value("Alice"));
}
```

### Exercise 1.2: Request Parameters
**Difficulty**: Beginner  
**Time**: 20-25 minutes

**Objective**: Handle request parameters in your endpoints.

**Tasks**:
1. Add a greeting endpoint `/greet?name=YourName`
2. Return a personalized greeting based on the name parameter
3. Handle the case when no name is provided (default greeting)
4. Write tests for both scenarios

### Exercise 1.3: POST Endpoint with Request Body
**Difficulty**: Intermediate  
**Time**: 30-40 minutes

**Objective**: Create an endpoint that accepts POST requests with JSON body.

**Tasks**:
1. Create a `Message` class with fields: `id`, `text`, `timestamp`
2. Add a POST endpoint at `/api/messages`
3. Accept a message in the request body
4. Return the message with an auto-generated ID and timestamp
5. Write comprehensive tests including validation

## 🎯 Exercise Track 2: Testing & Quality

### Exercise 2.1: Integration Testing
**Difficulty**: Intermediate  
**Time**: 25-30 minutes

**Objective**: Write comprehensive integration tests.

**Tasks**:
1. Create a test that makes multiple API calls in sequence
2. Test that the application context loads all beans correctly
3. Test the `/actuator/health` endpoint
4. Verify Prometheus metrics endpoint returns data

### Exercise 2.2: Error Handling
**Difficulty**: Intermediate  
**Time**: 30-35 minutes

**Objective**: Implement proper error handling.

**Tasks**:
1. Create a custom exception class
2. Add a global exception handler using `@ControllerAdvice`
3. Test error scenarios (404, 500, validation errors)
4. Ensure error responses are properly formatted

**Sample Implementation**:
```java
@ControllerAdvice
class GlobalExceptionHandler {
    @ExceptionHandler(NotFoundException.class)
    public ResponseEntity<String> handleNotFound(NotFoundException e) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                             .body(e.getMessage());
    }
}
```

### Exercise 2.3: Test Coverage
**Difficulty**: Beginner  
**Time**: 15-20 minutes

**Objective**: Measure and improve test coverage.

**Tasks**:
1. Add JaCoCo plugin to `pom.xml`
2. Run tests with coverage: `mvn test jacoco:report`
3. View coverage report in `target/site/jacoco/index.html`
4. Aim for >80% line coverage

## 🎯 Exercise Track 3: DevSecOps

### Exercise 3.1: Dependency Management
**Difficulty**: Beginner  
**Time**: 15-20 minutes

**Objective**: Learn to manage dependencies securely.

**Tasks**:
1. Run `mvn dependency:tree` to view all dependencies
2. Identify transitive dependencies
3. Run Trivy scan: `trivy fs app/`
4. Review any vulnerabilities found

### Exercise 3.2: Static Code Analysis
**Difficulty**: Intermediate  
**Time**: 25-30 minutes

**Objective**: Add static code analysis to your build.

**Tasks**:
1. Add SpotBugs plugin to `pom.xml`:
```xml
<plugin>
    <groupId>com.github.spotbugs</groupId>
    <artifactId>spotbugs-maven-plugin</artifactId>
    <version>4.7.3.6</version>
</plugin>
```
2. Run: `mvn spotbugs:check`
3. Review and fix any issues found
4. Add to CI/CD pipeline

### Exercise 3.3: Secrets Management
**Difficulty**: Advanced  
**Time**: 40-45 minutes

**Objective**: Properly handle sensitive configuration.

**Tasks**:
1. Move hardcoded values to `application.properties`
2. Use environment variables for sensitive data
3. Document required environment variables in README
4. Test with different configurations

## 🎯 Exercise Track 4: Containerization

### Exercise 4.1: Optimize Dockerfile
**Difficulty**: Intermediate  
**Time**: 30-35 minutes

**Objective**: Create a more efficient Docker image.

**Tasks**:
1. Implement multi-stage build in Dockerfile
2. Reduce final image size
3. Add health check instruction
4. Compare image sizes: `docker images`

**Sample Multi-stage Build**:
```dockerfile
# Stage 1: Build
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:8080/health || exit 1
ENTRYPOINT ["java", "-jar", "app.jar"]
```

### Exercise 4.2: Docker Compose
**Difficulty**: Intermediate  
**Time**: 25-30 minutes

**Objective**: Run the application with dependencies.

**Tasks**:
1. Create `docker-compose.yml` in the root directory
2. Define services: app, prometheus, loki (optional)
3. Configure networking between services
4. Test with: `docker-compose up`

### Exercise 4.3: Container Security
**Difficulty**: Advanced  
**Time**: 35-40 minutes

**Objective**: Secure your container image.

**Tasks**:
1. Run container as non-root user
2. Scan image with Trivy: `trivy image java-cicd-demo:latest`
3. Address any HIGH or CRITICAL vulnerabilities
4. Use distroless base image (optional challenge)

## 🎯 Exercise Track 5: CI/CD Pipeline

### Exercise 5.1: Understand the Pipeline
**Difficulty**: Beginner  
**Time**: 20-25 minutes

**Objective**: Understand the existing GitHub Actions workflow.

**Tasks**:
1. Review `.github/workflows/app-deploy.yml`
2. Draw a flowchart of the pipeline stages
3. Identify:
   - When the pipeline runs
   - What happens in each job
   - How artifacts are passed between jobs
   - Security scans performed

### Exercise 5.2: Add Code Quality Checks
**Difficulty**: Intermediate  
**Time**: 30-35 minutes

**Objective**: Enhance the CI pipeline with quality checks.

**Tasks**:
1. Add a new job in the workflow for code quality
2. Run SpotBugs or PMD
3. Fail the build if quality thresholds aren't met
4. Upload results as artifacts

### Exercise 5.3: Create a Release Pipeline
**Difficulty**: Advanced  
**Time**: 45-50 minutes

**Objective**: Automate releases with semantic versioning.

**Tasks**:
1. Create a new workflow: `.github/workflows/release.yml`
2. Trigger on tag creation (e.g., `v1.0.0`)
3. Build and tag Docker image with the version
4. Create GitHub release with changelog
5. Upload JAR as release asset

## 🎯 Exercise Track 6: Kubernetes Deployment

### Exercise 6.1: Create Kubernetes Manifests
**Difficulty**: Intermediate  
**Time**: 35-40 minutes

**Objective**: Deploy the application to Kubernetes.

**Tasks**:
1. Create a Deployment manifest
2. Create a Service manifest (ClusterIP)
3. Create a ConfigMap for configuration
4. Test locally with Minikube or kind

**Sample Deployment**:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: java-cicd-demo
spec:
  replicas: 2
  selector:
    matchLabels:
      app: java-cicd-demo
  template:
    metadata:
      labels:
        app: java-cicd-demo
    spec:
      containers:
      - name: app
        image: ghcr.io/diogoguedes11/java-cicd:latest
        ports:
        - containerPort: 8080
        livenessProbe:
          httpGet:
            path: /health
            port: 8080
        readinessProbe:
          httpGet:
            path: /health
            port: 8080
```

### Exercise 6.2: Add Health Probes
**Difficulty**: Beginner  
**Time**: 15-20 minutes

**Objective**: Configure proper health checks.

**Tasks**:
1. Add liveness probe to Deployment
2. Add readiness probe to Deployment
3. Test probe behavior by stopping the app
4. Observe Kubernetes restarting the pod

### Exercise 6.3: Resource Management
**Difficulty**: Intermediate  
**Time**: 25-30 minutes

**Objective**: Configure resource requests and limits.

**Tasks**:
1. Add CPU and memory requests
2. Add CPU and memory limits
3. Test behavior under load
4. Use `kubectl top` to monitor resource usage

## 🎓 Challenge Exercises

### Challenge 1: Full Feature Development
**Difficulty**: Advanced  
**Time**: 2-3 hours

**Objective**: Implement a complete feature from scratch.

**Tasks**:
1. Design a TODO API with CRUD operations
2. Use an in-memory data structure (no database)
3. Write comprehensive tests (aim for >90% coverage)
4. Add OpenAPI/Swagger documentation
5. Update Docker and K8s configurations
6. Ensure all security scans pass

### Challenge 2: Observability Stack
**Difficulty**: Advanced  
**Time**: 2-3 hours

**Objective**: Set up complete observability.

**Tasks**:
1. Set up Prometheus and Grafana locally
2. Configure Loki for log aggregation
3. Create custom application metrics
4. Build Grafana dashboards
5. Set up alerts for error rates

### Challenge 3: Production-Ready Pipeline
**Difficulty**: Expert  
**Time**: 4-5 hours

**Objective**: Build a production-grade CI/CD pipeline.

**Tasks**:
1. Implement automated semantic versioning
2. Add deployment strategies (blue-green or canary)
3. Integrate with external security scanning tools
4. Add automated rollback on failure
5. Implement approval gates for production
6. Set up notifications (Slack, email)

## 📊 Progress Tracking

Use this checklist to track your progress:

### Beginner Track
- [ ] Exercise 1.1: Basic REST API Extension
- [ ] Exercise 1.2: Request Parameters
- [ ] Exercise 3.1: Dependency Management
- [ ] Exercise 5.1: Understand the Pipeline
- [ ] Exercise 6.2: Add Health Probes

### Intermediate Track
- [ ] Exercise 1.3: POST Endpoint
- [ ] Exercise 2.1: Integration Testing
- [ ] Exercise 2.2: Error Handling
- [ ] Exercise 3.2: Static Code Analysis
- [ ] Exercise 4.1: Optimize Dockerfile
- [ ] Exercise 5.2: Add Code Quality Checks
- [ ] Exercise 6.1: Create Kubernetes Manifests

### Advanced Track
- [ ] Exercise 3.3: Secrets Management
- [ ] Exercise 4.3: Container Security
- [ ] Exercise 5.3: Create a Release Pipeline
- [ ] Challenge 1: Full Feature Development
- [ ] Challenge 2: Observability Stack
- [ ] Challenge 3: Production-Ready Pipeline

## 🆘 Getting Help

- Check the main [TUTORIAL.md](TUTORIAL.md) for foundational concepts
- Review existing code for examples
- Search GitHub Issues for similar problems
- Join the discussion in GitHub Discussions

## 🎉 Completion

Once you've completed the exercises:
1. Commit your changes
2. Push to your fork
3. Share your learnings!
4. Consider contributing improvements back to this repository

Good luck and happy learning! 🚀
