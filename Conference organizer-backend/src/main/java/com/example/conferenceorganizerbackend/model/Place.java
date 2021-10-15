package com.example.conferenceorganizerbackend.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "place")
public class Place {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int placeId;

    @Column(name="name")
    private String name;

    @Column(name = "number_of_places")
    private Integer numberOfPlaces;

    @ManyToOne
    @JoinColumn(name = "location_id", nullable = false)
    private Location location;

}
