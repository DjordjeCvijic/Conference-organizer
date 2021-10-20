package com.example.conferenceorganizerbackend.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "event")
public class Event {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int eventId;

    @Column(name="name",nullable = false)
    private String name;

    @Column(name = "description",nullable = false)
    private String description;

    @Column(name = "date_from",nullable = false)
    private LocalDateTime dateFrom;

    @Column(name = "date_to",nullable = false)
    private LocalDateTime dateTo;


    @Column(name = "access_link")
    private LocalDateTime accessLink;

    @Column(name = "access_password")
    private LocalDateTime accessPassword;

    @ManyToOne
    @JoinColumn(name = "lecturer_id")
    private Person lecturer;

    @ManyToOne
    @JoinColumn(name = "moderator_id", nullable = false)
    private Person Moderator;

    @ManyToOne
    @JoinColumn(name = "place_id",nullable = false)
    private Place place;

    @ManyToOne
    @JoinColumn(name = "event_type_id",nullable = false)
    private EventType eventType;

    @ManyToOne
    @JoinColumn(name = "session_id",nullable = false)
    private Session session;


    //gale strani kljucevi
}
