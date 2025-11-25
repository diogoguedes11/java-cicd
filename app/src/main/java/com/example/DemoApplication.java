package com.example;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@RestController
class HelloController {

  @GetMapping("/")
  public String hello() {
    logger.info("Hello endpoint accessed");
    return "Hello from Java CICD Demo!";
  }
}

@RestController
class HealthController {

  @GetMapping("/health")
  public String health() {
    logger.info("Health endpoint accessed");
    return "OK";
  }
}

@RestController
class InfoController {

  @GetMapping("/info")
  public String info() {
    logger.info("Info endpoint accessed");
    return "Java CICD Demo Application v1.0";
  }
}