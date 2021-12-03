package com.example.conferenceorganizerbackend.controller;

import com.example.conferenceorganizerbackend.dto.GradesFromPersonDto;
import com.example.conferenceorganizerbackend.dto.GradingSubjectDto;
import com.example.conferenceorganizerbackend.services.EvaluationService;
import javassist.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/evaluation")
public class EvaluationController {
    @Autowired
    private EvaluationService evaluationService;

    @PostMapping("/save-grades")
    public void saveGrades(@RequestBody GradesFromPersonDto gradesFromPersonDto) throws NotFoundException {
        evaluationService.saveGrades(gradesFromPersonDto);
    }
    @PostMapping("/get-grades")
    public List<GradingSubjectDto> getAllForConference(@RequestBody Integer conferenceId) throws NotFoundException {
        return evaluationService.getAllForConference(conferenceId);
    }
}
