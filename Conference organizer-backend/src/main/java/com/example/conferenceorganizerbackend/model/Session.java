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
@Table(name = "session")
public class Session {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer session_id;

    @Column(name = "name",nullable = false)
    private String name;

    @Column(name = "description",nullable = false)
    private String description;


    @Column(name = "is_online",nullable = false)
    private Boolean isOnline;

    @ManyToOne
    @JoinColumn(name = "conference_id",nullable = false)
    private Conference conference;

    @ManyToOne
    @JoinColumn(name = "moderator_id",nullable = false)
    private Person moderator;
}
