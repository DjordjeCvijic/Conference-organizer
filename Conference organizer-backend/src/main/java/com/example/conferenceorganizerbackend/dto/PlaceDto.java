package com.example.conferenceorganizerbackend.dto;

import com.example.conferenceorganizerbackend.model.Location;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor

public class PlaceDto {


    private Integer placeId;
    private String name;
    private Integer locationId;



}