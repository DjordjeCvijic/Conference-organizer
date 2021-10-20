package com.example.conferenceorganizerbackend.services;

import com.example.conferenceorganizerbackend.repository.PersonEventRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PersonEventService {
    @Autowired
    private PersonEventRepository personEventRepository;
}
