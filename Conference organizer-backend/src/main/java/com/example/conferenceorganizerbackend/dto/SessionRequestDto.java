package com.example.conferenceorganizerbackend.dto;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class SessionRequestDto {

    private String name;
    private String description;
    private String moderatorEmail;
    private  boolean isOnline;
}
