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
@Table(name = "person")
public class Person {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer personId;

    @Column(name="first_name")
    private String firstName;


    @Column(name="last_name")
    private String lastName;


    @Column(name="email",nullable = false)
    private String email;

    @Column(name="password", nullable = false)
    private String password;
}
