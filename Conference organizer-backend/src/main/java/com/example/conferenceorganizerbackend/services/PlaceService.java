package com.example.conferenceorganizerbackend.services;

import com.example.conferenceorganizerbackend.repository.PlaceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PlaceService {

    @Autowired
    private PlaceRepository placeRepository;
}
