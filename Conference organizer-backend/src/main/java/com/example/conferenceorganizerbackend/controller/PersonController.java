package com.example.conferenceorganizerbackend.controller;

import com.example.conferenceorganizerbackend.ExistingEmailException;
import com.example.conferenceorganizerbackend.dto.LoginRequest;
import com.example.conferenceorganizerbackend.dto.SessionEventInfoDto;
import com.example.conferenceorganizerbackend.model.Person;
import com.example.conferenceorganizerbackend.services.PersonService;
import javassist.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.security.NoSuchAlgorithmException;
import java.util.List;


@RestController
@RequestMapping("/person")
public class PersonController {
    @Autowired
    private PersonService personService;


    @PostMapping("/registration")
    public Person registration(@RequestBody Person person) throws ExistingEmailException, NoSuchAlgorithmException {
        return personService.registration(person);

    }


    @PostMapping("/login")

    public Person login(@RequestBody LoginRequest loginRequest) throws NotFoundException, NoSuchAlgorithmException {
        return personService.login(loginRequest);

    }

    @PostMapping("/exist")
    public Boolean personExist(@RequestBody String email) {
        return personService.personExist(email);
    }

    @PostMapping("/get-sessions-events-for-supervision")
    public List<SessionEventInfoDto> getSessionAndEventForSupervision(@RequestBody String email){
        return personService.getMySessionEndEventForSupervision(email);
    }

}
