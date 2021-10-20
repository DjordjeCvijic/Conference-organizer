package com.example.conferenceorganizerbackend.repository;

import com.example.conferenceorganizerbackend.model.Conference;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ConferenceRepository extends JpaRepository<Conference,Integer> {
}
