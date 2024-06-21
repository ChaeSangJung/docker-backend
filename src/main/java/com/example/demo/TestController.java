package com.example.demo;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class TestController {
    @CrossOrigin(origins = {"http://localhost:3000", "http://localhost:20001", "https://example.net"})
    @GetMapping("/test")
    public Map<String, Object> test() {
        Map<String, Object> response = new HashMap<>();
        response.put("message", "hello world");

        List<Map<String, Object>> dataList = new ArrayList<>();

        Map<String, Object> dataItem1 = new HashMap<>();
        dataItem1.put("name", "Peter");
        dataItem1.put("id", 1);
        dataList.add(dataItem1);

        Map<String, Object> dataItem2 = new HashMap<>();
        dataItem2.put("name", "John");
        dataItem2.put("id", 2);
        dataList.add(dataItem2);

        response.put("data", dataList);
        return response;
    }
}
