package com.example.conferenceorganizerbackend.controller;

import com.example.conferenceorganizerbackend.dto.GradingSubjectDto;
import com.example.conferenceorganizerbackend.dto.PersonConferenceDto;
import com.example.conferenceorganizerbackend.services.GradingSubjectService;
import javassist.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/grading-subject")
public class GradingSubjectController {

    @Autowired
    private GradingSubjectService gradingSubjectService;

    @PostMapping("/get-all")
    public List<GradingSubjectDto> getAllForConference(@RequestBody Integer conferenceId) throws NotFoundException {
        return gradingSubjectService.getAllForConference(conferenceId);
    }
    @PostMapping("/is-grading-done")
    public boolean isGradingDone(@RequestBody PersonConferenceDto personConferenceDto) throws NotFoundException {
        return  gradingSubjectService.isGradingDone(personConferenceDto);
    }
}
