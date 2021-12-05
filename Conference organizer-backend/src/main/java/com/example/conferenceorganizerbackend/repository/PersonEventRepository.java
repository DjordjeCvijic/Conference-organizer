package com.example.conferenceorganizerbackend.repository;

import com.example.conferenceorganizerbackend.compositekey.PersonEventKey;
import com.example.conferenceorganizerbackend.model.Event;
import com.example.conferenceorganizerbackend.model.Person;
import com.example.conferenceorganizerbackend.model.PersonEvent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PersonEventRepository extends JpaRepository<PersonEvent,PersonEventKey> {
    List<PersonEvent> findAllByPerson(Person person);
}
