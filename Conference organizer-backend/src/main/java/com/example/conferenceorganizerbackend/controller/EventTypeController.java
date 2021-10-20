package com.example.conferenceorganizerbackend.controller;

import com.example.conferenceorganizerbackend.services.EventTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/event-type")
public class EventTypeController {
    @Autowired
    private EventTypeService eventTypeService;
}
