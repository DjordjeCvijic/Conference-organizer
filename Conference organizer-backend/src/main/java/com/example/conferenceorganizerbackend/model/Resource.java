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
@Table(name = "resource")
public class Resource {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer resourceId;

    @Column(name="name",nullable = false)
    private String name;
}
