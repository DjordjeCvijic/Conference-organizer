package com.example.conferenceorganizerbackend.controller;

import com.example.conferenceorganizerbackend.dto.UserEventDto;
import com.example.conferenceorganizerbackend.services.PersonEventService;
import javassist.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/person-event")
public class PersonEventController {
    @Autowired
    private PersonEventService personEventService;

    @PostMapping("is-subscribed")
    public boolean isSubscribed(@RequestBody UserEventDto userEventDto) throws NotFoundException {
        return  personEventService.isSubscribed(userEventDto);
    }

    @PostMapping("subscribe")
    public void subscribe(@RequestBody UserEventDto userEventDto) throws NotFoundException {
          personEventService.subscribe(userEventDto);
    }
}
