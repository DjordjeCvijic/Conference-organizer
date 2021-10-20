package com.example.conferenceorganizerbackend.controller;

import com.example.conferenceorganizerbackend.services.PlaceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/place")
public class PlaceController {
    @Autowired
    private PlaceService placeService;
}
