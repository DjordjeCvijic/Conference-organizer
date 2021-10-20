package com.example.conferenceorganizerbackend.services;

import com.example.conferenceorganizerbackend.repository.EvaluationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EvaluationService {
    @Autowired
    private EvaluationRepository evaluationRepository;
}
