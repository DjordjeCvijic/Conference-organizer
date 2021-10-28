package com.example.conferenceorganizerbackend.services;

import com.example.conferenceorganizerbackend.model.GradingSubject;
import com.example.conferenceorganizerbackend.repository.GradingSubjectRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GradingSubjectService {

    @Autowired
    private GradingSubjectRepository gradingSubjectRepository;

    public GradingSubject save(GradingSubject gradingSubjectToSave){
        return gradingSubjectRepository.save(gradingSubjectToSave);
    }
}
