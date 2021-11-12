package com.example.conferenceorganizerbackend.controller;

import com.example.conferenceorganizerbackend.dto.EventToEditDto;
import com.example.conferenceorganizerbackend.model.Event;
import com.example.conferenceorganizerbackend.services.EventService;
import javassist.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/event")
public class EventController {

    @Autowired
    private EventService eventService;


    @PostMapping("get-by-id")
    public EventToEditDto getEventById(@RequestBody int id) throws NotFoundException {
        return eventService.getEventById(id);
    }

    @PostMapping("/save")
    public Event saveEvent(@RequestBody EventToEditDto eventToEditDto){
        return eventService.saveEventDto(eventToEditDto);

    }
}
