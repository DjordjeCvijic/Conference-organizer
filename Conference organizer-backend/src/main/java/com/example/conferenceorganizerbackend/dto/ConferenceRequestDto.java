package com.example.conferenceorganizerbackend.dto;

import com.example.conferenceorganizerbackend.model.Location;
import com.example.conferenceorganizerbackend.model.Person;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class ConferenceRequestDto {

    private String name;
    private String description;
    private String dateFrom;
    private String dateTo;
    private Integer locationId;
    private Integer creatorId;


    private List<String> gradingSubjectList;
    private List<SessionRequestDto>sessionRequestDtoList;


}
