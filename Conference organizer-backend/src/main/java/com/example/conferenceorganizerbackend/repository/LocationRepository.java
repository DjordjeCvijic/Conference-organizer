package com.example.conferenceorganizerbackend.repository;

import com.example.conferenceorganizerbackend.model.Location;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LocationRepository extends JpaRepository<Location,Integer> {
}
