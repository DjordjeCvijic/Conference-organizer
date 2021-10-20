package com.example.conferenceorganizerbackend.controller;

import com.example.conferenceorganizerbackend.services.PersonEventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/person-event")
public class PersonEventController {
    @Autowired
    private PersonEventService personEventService;
}
