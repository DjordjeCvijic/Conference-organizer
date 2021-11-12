package com.example.conferenceorganizerbackend.repository;

import com.example.conferenceorganizerbackend.model.Conference;
import com.example.conferenceorganizerbackend.model.Person;
import com.example.conferenceorganizerbackend.model.Session;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SessionRepository extends JpaRepository<Session,Integer> {

    List<Session> findAllByModerator(Person moderator );

    List<Session> findAllByConference(Conference conference);
}
