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
@Table(name = "event_type")
public class EventType {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer event_type_id;

    @Column(name = "name",nullable = false)
    private String name;


}
