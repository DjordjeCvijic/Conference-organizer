package com.example.conferenceorganizerbackend.controller;

import com.example.conferenceorganizerbackend.services.PersonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/person")
public class PersonController {
    @Autowired
    private PersonService personService;
}
