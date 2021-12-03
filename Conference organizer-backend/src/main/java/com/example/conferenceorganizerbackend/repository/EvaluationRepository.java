package com.example.conferenceorganizerbackend.repository;

import com.example.conferenceorganizerbackend.compositekey.EvaluationKey;
import com.example.conferenceorganizerbackend.model.Evaluation;
import com.example.conferenceorganizerbackend.model.Person;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EvaluationRepository  extends JpaRepository<Evaluation, EvaluationKey> {


    List<Evaluation> findAllByPerson(Person person);

    List<Evaluation> findAllByEvaluationKeyGradingSubjectId(Integer gradingSubjectId);
}
