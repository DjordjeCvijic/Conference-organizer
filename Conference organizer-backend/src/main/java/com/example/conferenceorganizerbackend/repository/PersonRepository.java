package com.example.conferenceorganizerbackend.repository;

import com.example.conferenceorganizerbackend.model.Person;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PersonRepository extends JpaRepository<Person,Integer> {
}
