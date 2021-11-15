package com.example.conferenceorganizerbackend.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class GradingSubjectDto {

    private Integer gradingSubjectId;
    private String gradingSubjectName;
    private Integer grade;
}
