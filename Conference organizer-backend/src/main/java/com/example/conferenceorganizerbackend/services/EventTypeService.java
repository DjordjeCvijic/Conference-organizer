package com.example.conferenceorganizerbackend.services;

import com.example.conferenceorganizerbackend.repository.EventTypeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EventTypeService {

    @Autowired
    private EventTypeRepository eventTypeRepository;
}
