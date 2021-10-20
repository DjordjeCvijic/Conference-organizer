package com.example.conferenceorganizerbackend.repository;

import com.example.conferenceorganizerbackend.model.GradingSubject;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface GradingSubjectRepository extends JpaRepository<GradingSubject,Integer> {
}
