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

    @Column(name="name")
    private String name;

    @Column(name = "description")
    private String description;

    @Column(name = "date_from")
    private LocalDateTime dateFrom;

    @Column(name = "date_to")
    private LocalDateTime dateTo;

    @Column(name = "is_online")
    private Boolean isOnline;

    @Column(name = "access_link")
    private LocalDateTime accessLink;

    @Column(name = "access_password")
    private LocalDateTime accessPassword;

    //gale strani kljucevi
}
