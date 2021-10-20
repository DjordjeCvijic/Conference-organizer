package com.example.conferenceorganizerbackend.controller;

import com.example.conferenceorganizerbackend.services.EventResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/event-resource")
public class EventResourceController {

    @Autowired
    private EventResourceService eventResourceService;
}
