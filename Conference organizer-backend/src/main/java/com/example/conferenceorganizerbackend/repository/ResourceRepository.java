package com.example.conferenceorganizerbackend.repository;

import com.example.conferenceorganizerbackend.model.Resource;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ResourceRepository extends JpaRepository<Resource,Integer> {
}
