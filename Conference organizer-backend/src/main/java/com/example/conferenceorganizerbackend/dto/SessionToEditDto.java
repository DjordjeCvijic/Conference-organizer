package com.example.conferenceorganizerbackend.dto;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.LinkedList;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SessionToEditDto {

    private Integer sessionId;
    private String name;
    private String description;
    private List<EventDto> eventList=new LinkedList<>();


    public void addEvent(EventDto eventDto){
        eventList.add(eventDto);
    }

}
