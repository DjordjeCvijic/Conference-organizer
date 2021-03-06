package com.example.conferenceorganizerbackend.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.time.LocalTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "event")
public class Event {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer eventId;

    @Column(name="name",nullable = false)
    private String name;

    @Column(name = "description",nullable = false)
    private String description;

    @Column(name = "date",nullable = false)
    private LocalDateTime date;

    @Column(name = "time_from",nullable = false)
    private LocalTime timeFrom;

    @Column(name = "time_to",nullable = false)
    private LocalTime timeTo;


    @Column(name = "access_link")
    private String accessLink;

    @Column(name = "access_password")
    private String accessPassword;

    @ManyToOne
    @JoinColumn(name = "lecturer_id")
    private Person lecturer;

    @ManyToOne
    @JoinColumn(name = "moderator_id", nullable = false)
    private Person moderator;

    @ManyToOne
    @JoinColumn(name = "place_id",nullable = false)
    private Place place;

    @ManyToOne
    @JoinColumn(name = "event_type_id",nullable = false)
    private EventType eventType;

    @ManyToOne
    @JoinColumn(name = "session_id",nullable = false)
    private Session session;



}
