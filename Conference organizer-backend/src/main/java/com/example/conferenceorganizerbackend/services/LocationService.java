package com.example.conferenceorganizerbackend.services;


import com.example.conferenceorganizerbackend.model.Location;
import com.example.conferenceorganizerbackend.repository.LocationRepository;
import javassist.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LocationService {
    @Autowired
    private LocationRepository locationRepository;

    public Location getById(Integer locationId) throws NotFoundException {
        return locationRepository.findById(locationId).orElseThrow(()-> new NotFoundException("Locacija sa id ne postoji"));
    }

    public List<Location> getAll() {
        return locationRepository.findAll();
    }
}
