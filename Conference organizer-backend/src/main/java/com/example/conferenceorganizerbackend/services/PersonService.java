package com.example.conferenceorganizerbackend.services;

import com.example.conferenceorganizerbackend.repository.PersonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PersonService {

    @Autowired
    private PersonRepository personRepository;
}
