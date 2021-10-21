package com.example.conferenceorganizerbackend.controller;

import com.example.conferenceorganizerbackend.ExistingEmailException;
import com.example.conferenceorganizerbackend.dto.LoginRequest;
import com.example.conferenceorganizerbackend.model.Person;
import com.example.conferenceorganizerbackend.services.PersonService;
import javassist.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.security.NoSuchAlgorithmException;


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
//    @CrossOrigin
    public Person login(@RequestBody LoginRequest loginRequest) throws NotFoundException, NoSuchAlgorithmException {
        return personService.login(loginRequest);

    }

}
