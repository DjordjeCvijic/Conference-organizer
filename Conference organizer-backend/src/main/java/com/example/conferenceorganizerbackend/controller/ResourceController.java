package com.example.conferenceorganizerbackend.controller;

import com.example.conferenceorganizerbackend.model.Resource;
import com.example.conferenceorganizerbackend.services.ResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/resource")
public class ResourceController {

    @Autowired
    private ResourceService resourceService;

    @GetMapping("get-all")
    public List<Resource> getAll(){
        return resourceService.getAll();
    }
}
