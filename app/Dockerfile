# Use a base image with Java runtime
FROM eclipse-temurin:17-jre

# Set the working directory
WORKDIR /app

# Copy the JAR file into the container
COPY target/java-cicd-demo-0.1.0-SNAPSHOT.jar app.jar

# Expose the application port
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]