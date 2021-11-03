package com.example.conferenceorganizerbackend.services;

import com.example.conferenceorganizerbackend.model.Session;
import com.example.conferenceorganizerbackend.repository.SessionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SessionService {

    @Autowired
    private SessionRepository sessionRepository;
    @Autowired
    private PersonService personService;


    public Session saveSession(Session sessionToSave){
        return sessionRepository.save(sessionToSave);
    }

    public List<Session> getMySessionsForSupervision(String email) {
        return sessionRepository.findAllByModerator(personService.getPersonByEmail(email));
    }
}
