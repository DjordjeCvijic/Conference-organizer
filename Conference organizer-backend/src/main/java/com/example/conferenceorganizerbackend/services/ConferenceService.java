package com.example.conferenceorganizerbackend.services;

import com.example.conferenceorganizerbackend.model.Conference;
import com.example.conferenceorganizerbackend.repository.ConferenceRepository;
import javassist.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ConferenceService {

    @Autowired
    private ConferenceRepository conferenceRepository;

    public Conference findById(int id) throws NotFoundException {
        return conferenceRepository.findById(id)
                .orElseThrow(() -> new NotFoundException("Nije pronađen sadržaj sa id-em:" + id));
    }
}
