package com.example.conferenceorganizerbackend.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.LinkedList;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class EventToEditDto {
    private Integer eventId;
    private String name;
    private String description;
    private String lecturerEmail;
    private Boolean isOnline;
    private String accessLink="";
    private String accessPassword="";

    private List<Integer> resourceIdList=new LinkedList<>();

    public void addResourceId(Integer id){
        resourceIdList.add(id);
    }

}
