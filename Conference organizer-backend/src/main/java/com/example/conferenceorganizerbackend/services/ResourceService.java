package com.example.conferenceorganizerbackend.services;

import com.example.conferenceorganizerbackend.model.Resource;
import com.example.conferenceorganizerbackend.repository.ResourceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ResourceService {

    @Autowired
    private ResourceRepository resourceRepository;

    public List<Resource> getAll() {
        return  resourceRepository.findAll();
    }
}
