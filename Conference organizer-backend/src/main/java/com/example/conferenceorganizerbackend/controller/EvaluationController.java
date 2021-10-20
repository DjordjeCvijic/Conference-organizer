package com.example.conferenceorganizerbackend.controller;

import com.example.conferenceorganizerbackend.services.EvaluationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/evaluation")
public class EvaluationController {
    @Autowired
    private EvaluationService evaluationService;
}
