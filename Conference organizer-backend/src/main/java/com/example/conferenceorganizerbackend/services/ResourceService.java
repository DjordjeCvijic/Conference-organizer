package com.example.conferenceorganizerbackend.services;

import com.example.conferenceorganizerbackend.repository.ResourceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ResourceService {

    @Autowired
    private ResourceRepository resourceRepository;
}
