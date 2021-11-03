package com.example.conferenceorganizerbackend.repository;

import com.example.conferenceorganizerbackend.model.Event;
import com.example.conferenceorganizerbackend.model.Person;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EventRepository extends JpaRepository<Event,Integer> {

    List<Event>findAllByModerator(Person moderator);
}
