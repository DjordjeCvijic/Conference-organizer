package com.example.conferenceorganizerbackend.services;

import com.example.conferenceorganizerbackend.dto.PlaceDto;
import com.example.conferenceorganizerbackend.model.Place;
import com.example.conferenceorganizerbackend.repository.PlaceRepository;
import javassist.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.LinkedList;
import java.util.List;

@Service
public class PlaceService {

    @Autowired
    private PlaceRepository placeRepository;
    @Autowired
    private LocationService locationService;

    public List<PlaceDto> getAllPlacesOnLocation(int locationId) throws NotFoundException {
        List<PlaceDto> resultList=new LinkedList<>();
        List<Place>placeList= placeRepository.findAllByLocation(locationService.getById(locationId));
        placeList.forEach(e->resultList.add(new PlaceDto(e.getPlaceId(),e.getName(),e.getLocation().getLocationId())));

        return resultList;
    }

    public Place getById(Integer id) {
        return placeRepository.findById(id).get();
    }
}
