package com.example;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class DemoApplication {
  private static final java.util.logging.Logger logger = LoggerFactory.getLogger(DemoApplication.class);

  public static void main(String[] args) {
    logger.info("Application starting");
    SpringApplication.run(DemoApplication.class, args);
  }
}

@RestController
class HelloController {
  private static final Logger logger = LoggerFactory.getLogger(DemoApplication.class);

  @GetMapping("/")
  public String hello() {
    logger.info("Hello endpoint accessed");
    return "Hello from Java CICD Demo!";
  }
}

@RestController
class HealthController {
  private static final Logger logger = LoggerFactory.getLogger(DemoApplication.class);

  @GetMapping("/health")
  public String health() {
    logger.info("Health endpoint accessed");
    return "OK";
  }
}

@RestController
class InfoController {
  private static final Logger logger = LoggerFactory.getLogger(DemoApplication.class);

  @GetMapping("/info")
  public String info() {
    logger.info("Info endpoint accessed");
    return "Java CICD Demo Application v1.0";
  }
}