package com.example.conferenceorganizerbackend.services;

import com.example.conferenceorganizerbackend.dto.SessionToEditDto;
import com.example.conferenceorganizerbackend.model.Session;
import com.example.conferenceorganizerbackend.repository.SessionRepository;
import javassist.NotFoundException;
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

    public SessionToEditDto getSessionToEdit(int sessionId) throws NotFoundException {
        Session session=sessionRepository.findById(sessionId).orElseThrow(()-> new NotFoundException("ne postoji trazen asesija"));
        SessionToEditDto result=new SessionToEditDto();
        result.setSessionId(session.getSession_id());
        result.setName(session.getName());
        result.setDescription(session.getDescription());
        result.setLocationId(session.getConference().getLocation().getLocationId());
        //ovdje treba povuci sve events i dodati

        return result;
    }
}
