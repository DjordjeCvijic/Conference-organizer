package com.example.conferenceorganizerbackend.dto;

import com.example.conferenceorganizerbackend.model.EventType;
import com.example.conferenceorganizerbackend.model.Person;
import com.example.conferenceorganizerbackend.model.Place;
import com.example.conferenceorganizerbackend.model.Session;
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
public class EventDto {

    private Integer eventId;
    private String name;
    private String description;
    private String date;
    private String timeFrom;
    private String timeTo;
    private String moderatorEmail;
    private Integer placeId;
    private Integer eventTypeId;
    private Integer sessionId;
}
