FROM openjdk:17-jdk-slim
COPY app/target/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]