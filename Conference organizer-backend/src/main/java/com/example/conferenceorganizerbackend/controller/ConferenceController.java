package com.example.conferenceorganizerbackend.controller;

import com.example.conferenceorganizerbackend.dto.*;
import com.example.conferenceorganizerbackend.model.Conference;
import com.example.conferenceorganizerbackend.services.ConferenceService;
import javassist.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/conference")
public class ConferenceController {
    @Autowired
    ConferenceService conferenceService;

    @GetMapping
    public Conference findById(@RequestParam int id) throws NotFoundException {
        return conferenceService.getById(id);
    }

    @GetMapping("/all")
    public List<ConferenceInfoDto> getAll(){
        return conferenceService.getAll();
    }
    @PostMapping("/get-conferences-subscribed-to")
    public List<ConferenceInfoDto> getConferencesSubscribedTo(@RequestBody Integer personId) throws NotFoundException {
        return conferenceService.getConferencesSubscribedTo(personId);
    }

    @PostMapping("/add")
    public Conference save(@RequestBody ConferenceRequestDto conferenceRequestDto) throws NotFoundException {
        return conferenceService.save(conferenceRequestDto);
    }

    @PostMapping("all-to-show")
    public ConferenceToShowDto getConferenceToShow(@RequestBody Integer conferenceId){
        return conferenceService.getConferenceToShow(conferenceId);
    }
    @PostMapping("is-subscribed-to-conference")
    public boolean isSubscribed(@RequestBody PersonConferenceDto personConferenceDto) throws NotFoundException {
        return  conferenceService.isSubscribedToConference(personConferenceDto);
    }

}
