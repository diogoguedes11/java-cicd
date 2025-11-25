# Use a base image with Java runtime
FROM eclipse-temurin:17-jre
COPY target/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]