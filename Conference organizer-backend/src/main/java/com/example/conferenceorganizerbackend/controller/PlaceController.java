package com.example.conferenceorganizerbackend.controller;

import com.example.conferenceorganizerbackend.dto.PlaceDto;
import com.example.conferenceorganizerbackend.services.PlaceService;
import javassist.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/place")
public class PlaceController {
    @Autowired
    private PlaceService placeService;


    @PostMapping("all-on-location")
    public List<PlaceDto> getAllPlacesOnLocation(@RequestBody int locationId) throws NotFoundException {
        return placeService.getAllPlacesOnLocation(locationId);
    }
}