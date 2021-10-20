package com.example.conferenceorganizerbackend.repository;

import com.example.conferenceorganizerbackend.compositekey.EvaluationKey;
import com.example.conferenceorganizerbackend.model.Evaluation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EvaluationRepository  extends JpaRepository<Evaluation, EvaluationKey> {
}
