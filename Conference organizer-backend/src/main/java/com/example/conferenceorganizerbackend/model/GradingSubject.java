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
@Table(name = "grading_subject")
public class GradingSubject {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int gradingSubjectId;

    @Column(name="name",nullable = false)
    private String name;

    @ManyToOne
    @JoinColumn(name = "conference_id",nullable = false)
    private Conference conference;


}
