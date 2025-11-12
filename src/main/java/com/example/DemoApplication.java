package com.example;

import io.micrometer.core.instrument.MeterRegistry;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
public class DemoApplication {
    private static final Logger logger = LoggerFactory.getLogger(DemoApplication.class);

    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }

    @Bean
    public CommandLineRunner commandLineRunner(MeterRegistry registry) {
        return args -> {
            logger.info("Application started. Sending a test log to Loki.");
            registry.counter("dummy_app_startups").increment();
        };
    }

    @RestController
    class HelloController {
        @GetMapping("/")
        public String hello() {
            logger.info("Received request at root endpoint");
            return "Hello from Java CICD Demo!";
        }
    }
}
