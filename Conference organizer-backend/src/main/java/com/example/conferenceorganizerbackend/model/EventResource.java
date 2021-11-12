package com.example.conferenceorganizerbackend.model;


import com.example.conferenceorganizerbackend.compositekey.EvaluationKey;
import com.example.conferenceorganizerbackend.compositekey.EventResourceKey;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "event_resource")
public class EventResource {

    @EmbeddedId
    @Column(name = "event_resource_key")
    EventResourceKey eventResourceKey;

    @ManyToOne
    @MapsId("eventId")//kako se zove u veznoj tabel//mora se poklapati kao u kljucu
    @JoinColumn(name = "event_id", nullable = false)//kako se zove u ovoj
    @JsonIgnore
    private Event event;


    @ManyToOne
    @MapsId("resourceId")
    @JoinColumn(name = "resource_id", nullable = false)
    private Resource resource;


}
