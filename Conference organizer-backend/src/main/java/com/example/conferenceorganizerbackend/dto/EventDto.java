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
    private String dateFrom;
    private String dateTo;
    private String moderatorEmail;
    private String place;
    private Integer placeId;
    private String eventType;
    private Integer sessionId;
}
