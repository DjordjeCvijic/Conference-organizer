package com.example.conferenceorganizerbackend.controller;

import com.example.conferenceorganizerbackend.model.Conference;
import com.example.conferenceorganizerbackend.services.ConferenceService;
import javassist.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/conference")
public class ConferenceController {
    @Autowired
    ConferenceService conferenceService;

    @GetMapping
    public Conference findById(@RequestParam int id) throws NotFoundException {
        return conferenceService.findById(id);
    }
}
