package com.example.conferenceorganizerbackend.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class SessionEventInfoDto {

    private Integer id;
    private String type;
    private String partOfName;
    private Integer partOfId;
    private String name;

}
