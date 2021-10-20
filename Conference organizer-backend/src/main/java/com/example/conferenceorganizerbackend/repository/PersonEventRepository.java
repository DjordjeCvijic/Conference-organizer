package com.example.conferenceorganizerbackend.repository;

import com.example.conferenceorganizerbackend.compositekey.PersonEventKey;
import com.example.conferenceorganizerbackend.model.PersonEvent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PersonEventRepository extends JpaRepository<PersonEvent,PersonEventKey> {
}
