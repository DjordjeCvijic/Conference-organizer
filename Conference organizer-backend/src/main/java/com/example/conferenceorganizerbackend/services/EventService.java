package com.example.conferenceorganizerbackend.services;

import com.example.conferenceorganizerbackend.repository.EventRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EventService {

    @Autowired
    private EventRepository eventRepository;
}
