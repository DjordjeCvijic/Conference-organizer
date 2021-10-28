package com.example.conferenceorganizerbackend.services;

import com.example.conferenceorganizerbackend.model.Session;
import com.example.conferenceorganizerbackend.repository.SessionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SessionService {

    @Autowired
    private SessionRepository sessionRepository;


    public Session saveSession(Session sessionToSave){
        return sessionRepository.save(sessionToSave);
    }
}
