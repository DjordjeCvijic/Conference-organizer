package com.example.conferenceorganizerbackend.dto;

import io.swagger.models.auth.In;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class PersonConferenceDto {
    private Integer personId;
    private Integer conferenceId;
}
