package com.example.conferenceorganizerbackend.services;

import com.example.conferenceorganizerbackend.model.Event;
import com.example.conferenceorganizerbackend.model.Session;
import com.example.conferenceorganizerbackend.repository.EventRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EventService {

    @Autowired
    private EventRepository eventRepository;
    @Autowired
    private PersonService personService;

    public List<Event> getMyEventsForSupervision(String email) {
        return eventRepository.findAllByModerator(personService.getPersonByEmail(email));
    }


    public List<Event> getEventsOfSession(Session session){
        return eventRepository.findAllBySession(session);
    }


    public Event save(Event event){
        return eventRepository.save(event);
    }
}
