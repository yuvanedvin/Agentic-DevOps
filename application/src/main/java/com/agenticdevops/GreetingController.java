package com.agenticdevops;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class GreetingController {

    @GetMapping("/api/hello")
    public Greeting greet(@RequestParam(defaultValue = "world") String name) {
        return new Greeting("Hello, " + name + "!");
    }

    public record Greeting(String message) {
    }
}
