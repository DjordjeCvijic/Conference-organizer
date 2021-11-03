package com.example.conferenceorganizerbackend.services;

import com.example.conferenceorganizerbackend.ExistingEmailException;
import com.example.conferenceorganizerbackend.dto.LoginRequest;
import com.example.conferenceorganizerbackend.dto.SessionEventInfoDto;
import com.example.conferenceorganizerbackend.model.Event;
import com.example.conferenceorganizerbackend.model.Person;
import com.example.conferenceorganizerbackend.model.Session;
import com.example.conferenceorganizerbackend.repository.PersonRepository;
import javassist.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.MessageDigestPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.xml.bind.DatatypeConverter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.LinkedList;
import java.util.List;


@Service
public class PersonService {

    @Autowired
    private PersonRepository personRepository;
    @Autowired
    PasswordEncoder passwordEncoder;

    @Autowired
    private SessionService sessionService;
    @Autowired
    private EventService eventService;

    public Person registration(Person personToRegistration) throws ExistingEmailException, NoSuchAlgorithmException {
        if (personRepository.existsPersonByEmail(personToRegistration.getEmail()))
            throw new ExistingEmailException();
        MessageDigest md = MessageDigest.getInstance("MD5");
        md.update(personToRegistration.getPassword().getBytes());

        byte[] digest = md.digest();
        String myHash = DatatypeConverter
                .printHexBinary(digest).toUpperCase();
        personToRegistration.setPassword(myHash);
        return personRepository.save(personToRegistration);
    }

    public Person login(LoginRequest loginRequest) throws NotFoundException, NoSuchAlgorithmException {
        if (!personRepository.existsPersonByEmail(loginRequest.getEmail()))
            throw new NotFoundException("Email is incorrect");
        Person person = personRepository.findPersonByEmail(loginRequest.getEmail());
        MessageDigest md = MessageDigest.getInstance("MD5");
        md.update(loginRequest.getPassword().getBytes());

        byte[] digest = md.digest();
        String myHash = DatatypeConverter
                .printHexBinary(digest).toUpperCase();
        if (person.getPassword().equals(myHash))
            return person;
        else throw new NotFoundException("Password is incorrect");
    }

    public Person getById(Integer creatorId) throws NotFoundException {
        return personRepository.findById(creatorId).orElseThrow(() -> new NotFoundException("Osoba sa id ne postoji"));
    }

    public Boolean personExist(String email)  {
        if (!personRepository.existsPersonByEmail(email))
            return false;
        return true;
    }
    public Person getPersonByEmail(String email){
        return personRepository.findPersonByEmail(email);
    }

    public List<SessionEventInfoDto> getMySessionEndEventForSupervision(String email) {
        System.out.println(email);
        List<SessionEventInfoDto> result=new LinkedList<>();
        List<Session> sessionList=sessionService.getMySessionsForSupervision(email);
        List<Event>eventList=eventService.getMyEventsForSupervision(email);

        sessionList.forEach(e->result.add(new SessionEventInfoDto(e.getSession_id(),"session",e.getConference().getName(),e.getConference().getConference_id(),e.getName())));
        eventList.forEach(e->result.add(new SessionEventInfoDto(e.getEventId(),"event",e.getSession().getName(),e.getSession().getSession_id(),e.getName())));
        return result;
    }
}
