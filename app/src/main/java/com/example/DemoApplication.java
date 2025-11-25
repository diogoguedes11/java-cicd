package com.example;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

// Shared logger utility
class AppLogger {
  public static final Logger logger = LoggerFactory.getLogger("AppLogger");
}

@SpringBootApplication
public class DemoApplication {
  public static void main(String[] args) {
    AppLogger.logger.info("Application starting");
    SpringApplication.run(DemoApplication.class, args);
  }
}

@RestController
class HelloController {
  @GetMapping("/")
  public String hello() {
    AppLogger.logger.info("Hello endpoint accessed");
    return "Hello from Java CICD Demo!";
  }
}

@RestController
class HealthController {
  @GetMapping("/health")
  public String health() {
    AppLogger.logger.info("Health endpoint accessed");
    return "OK";
  }
}

@RestController
class InfoController {
  @GetMapping("/info")
  public String info() {
    AppLogger.logger.info("Info endpoint accessed");
    return "Java CICD Demo Application v1.0";
  }
}