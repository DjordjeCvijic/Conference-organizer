package com.example.conferenceorganizerbackend.controller;

import com.example.conferenceorganizerbackend.services.GradingSubjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/grading-subject")
public class GradingSubjectController {

    @Autowired
    private GradingSubjectService gradingSubjectService;
}
