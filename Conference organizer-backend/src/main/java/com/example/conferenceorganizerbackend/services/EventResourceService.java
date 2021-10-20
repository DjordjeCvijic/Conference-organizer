package com.example.conferenceorganizerbackend.services;

import com.example.conferenceorganizerbackend.repository.EventResourceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EventResourceService {
    @Autowired
    private EventResourceRepository eventResourceRepository;
}
