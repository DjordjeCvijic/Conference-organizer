package com.example.conferenceorganizerbackend.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class EventToShowDto {

    private Integer eventId;
    private String name;
    private String description;
    private String date;
    private String timeFrom;
    private String timeTo;
    private String place;
    private String accessLink;
    private String accessPassword;
    private boolean isOnline;
    private String lecturerEmail;
    private String eventType;
}
