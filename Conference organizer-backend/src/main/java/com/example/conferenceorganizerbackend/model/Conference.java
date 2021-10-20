package com.example.conferenceorganizerbackend.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "conference")
public class Conference {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer conference_id;

    @Column(name = "name",nullable = false)
    private String name;

    @Column(name = "description")
    private String description;

    @Column(name = "date_from",nullable = false)
    private LocalDateTime dateFrom;

    @Column(name = "date_to",nullable = false)
    private LocalDateTime dateTo;

    @Column(name = "image_path")
    private String imagePath;

    @ManyToOne
    @JoinColumn(name = "location_id",nullable = false)
    Location location;

    @ManyToOne
    @JoinColumn(name = "creator_id",nullable = false)
    Person creator;


}
