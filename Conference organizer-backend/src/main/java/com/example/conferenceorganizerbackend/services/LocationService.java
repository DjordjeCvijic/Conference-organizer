package com.example.conferenceorganizerbackend.services;


import com.example.conferenceorganizerbackend.repository.LocationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.stereotype.Service;

@Service
public class LocationService {
    @Autowired
    private LocationRepository locationRepository;
}
