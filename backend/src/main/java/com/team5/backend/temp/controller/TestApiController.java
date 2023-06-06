package com.team5.backend.temp.controller;

import com.team5.backend.temp.dto.PostRequest;
import com.team5.backend.temp.dto.PostResponse;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/test")
@RestController
public class TestApiController {

    @GetMapping("/get")
    public String testGetRequest(String input) {
        return "API response = " + input;
    }

    @PostMapping("/post")
    public PostResponse testPostRequest(PostRequest postRequest) {
        return PostResponse.from(postRequest);
    }
}
