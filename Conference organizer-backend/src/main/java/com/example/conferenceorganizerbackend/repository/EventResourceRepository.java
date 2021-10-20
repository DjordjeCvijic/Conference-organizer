package com.example.conferenceorganizerbackend.repository;

import com.example.conferenceorganizerbackend.compositekey.EventResourceKey;
import com.example.conferenceorganizerbackend.model.EventResource;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EventResourceRepository extends JpaRepository<EventResource,EventResourceKey> {
}
