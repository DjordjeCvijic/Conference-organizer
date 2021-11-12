package com.example.conferenceorganizerbackend.services;

import com.example.conferenceorganizerbackend.model.Event;
import com.example.conferenceorganizerbackend.model.EventResource;
import com.example.conferenceorganizerbackend.repository.EventResourceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EventResourceService {
    @Autowired
    private EventResourceRepository eventResourceRepository;


    public List<EventResource> getAllBuEvent(Event event){
        return eventResourceRepository.findAllByEvent(event);
    }

    public EventResource save(EventResource eventResource){
        return eventResourceRepository.save(eventResource);
    }
}
