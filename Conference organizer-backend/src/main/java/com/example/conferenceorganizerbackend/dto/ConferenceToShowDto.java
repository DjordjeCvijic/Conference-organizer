package com.example.conferenceorganizerbackend.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ConferenceToShowDto {
    private  Integer conferenceId;
    private String name;
    private String description;
    private String dateFrom;
    private String dateTo;
    private String location;
    private String creatorEmail;

//    private List<SessionEventInfoDto> sessionList=new LinkedList<>();
//
//    public void addSessionOnList(Integer sessionId,String sessionName){
//        SessionEventInfoDto tmp=new SessionEventInfoDto();
//        tmp.setId(sessionId);
//        tmp.setName(sessionName);
//        sessionList.add(tmp);
//    }
}
