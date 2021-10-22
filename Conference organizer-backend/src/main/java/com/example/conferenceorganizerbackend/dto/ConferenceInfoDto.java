package com.example.conferenceorganizerbackend.dto;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Column;
import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ConferenceInfoDto {
    private Integer conference_id;
    private String name;
    private String dateFrom;
    private String dateTo;
    private String location;
    private String creatorEmail;
}
