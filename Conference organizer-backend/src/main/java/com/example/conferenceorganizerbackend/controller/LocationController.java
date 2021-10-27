package com.example.conferenceorganizerbackend.controller;

import com.example.conferenceorganizerbackend.model.Location;
import com.example.conferenceorganizerbackend.services.LocationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/location")
public class LocationController {
    @Autowired
    private LocationService locationService;


    @GetMapping("/all")
    public List<Location> getAll(){
        return locationService.getAll();
    }
}
