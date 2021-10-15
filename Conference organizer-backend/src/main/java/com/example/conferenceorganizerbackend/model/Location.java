package com.example.conferenceorganizerbackend.model;


import lombok.*;

import javax.persistence.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "location")
public class Location {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int locationId;

    @Column(name="name",nullable = false)
    private String name;

    @Column(name="address",nullable = false)
    private String address;
}
