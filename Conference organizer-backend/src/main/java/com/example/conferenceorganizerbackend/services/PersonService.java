package com.example.conferenceorganizerbackend.services;

import com.example.conferenceorganizerbackend.ExistingEmailException;
import com.example.conferenceorganizerbackend.dto.LoginRequest;
import com.example.conferenceorganizerbackend.model.Person;
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


@Service
public class PersonService {

    @Autowired
    private PersonRepository personRepository;
    @Autowired
    PasswordEncoder passwordEncoder;

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
        if(person.getPassword().equals(myHash))
            return person;
        else throw new NotFoundException("Password is incorrect");
    }
}
