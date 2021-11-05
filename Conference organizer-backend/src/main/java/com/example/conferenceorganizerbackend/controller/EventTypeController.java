package com.example.conferenceorganizerbackend.controller;

import com.example.conferenceorganizerbackend.model.EventType;
import com.example.conferenceorganizerbackend.services.EventTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/event-type")
public class EventTypeController {
    @Autowired
    private EventTypeService eventTypeService;


    @GetMapping("/all")
    public List<EventType> getAll(){
      return  eventTypeService.getAll();
    }

}
