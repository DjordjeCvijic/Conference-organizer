package com.example.conferenceorganizerbackend.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class SessionToShowDto {

    private Integer sessionId;
    private String name;
    private String description;
    private String moderatorEmail;
    private String isOnline;
}
