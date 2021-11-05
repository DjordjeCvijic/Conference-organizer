package com.example.conferenceorganizerbackend.repository;

import com.example.conferenceorganizerbackend.model.Location;
import com.example.conferenceorganizerbackend.model.Place;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PlaceRepository extends JpaRepository<Place,Integer> {

    List<Place> findAllByLocation(Location location);
}
