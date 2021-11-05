package com.example.conferenceorganizerbackend.services;

import com.example.conferenceorganizerbackend.model.EventType;
import com.example.conferenceorganizerbackend.repository.EventTypeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EventTypeService {

    @Autowired
    private EventTypeRepository eventTypeRepository;

    public List<EventType> getAll() {
        return eventTypeRepository.findAll();
    }
}
