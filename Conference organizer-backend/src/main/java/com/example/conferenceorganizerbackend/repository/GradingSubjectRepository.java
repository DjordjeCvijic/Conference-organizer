package com.example.conferenceorganizerbackend.repository;

import com.example.conferenceorganizerbackend.model.Conference;
import com.example.conferenceorganizerbackend.model.GradingSubject;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GradingSubjectRepository extends JpaRepository<GradingSubject,Integer> {


    List<GradingSubject> findAllByConference(Conference conference);
}
