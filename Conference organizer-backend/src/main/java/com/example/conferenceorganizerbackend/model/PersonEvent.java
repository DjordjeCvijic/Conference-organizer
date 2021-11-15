package com.example.conferenceorganizerbackend.model;

import com.example.conferenceorganizerbackend.compositekey.PersonEventKey;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "person_event")
public class PersonEvent {

    @EmbeddedId
    @Column(name = "person_event_key")
    PersonEventKey personEventKey;

    @ManyToOne
    @MapsId("personId")//kako se zove u veznoj tabel//mora se poklapati kao u kljucu
    @JoinColumn(name = "person_id", nullable = false)//kako se zove u ovoj
    @JsonIgnore
    private Person person;


    @ManyToOne
    @MapsId("eventId")
    @JoinColumn(name = "event_id", nullable = false)
    @JsonIgnore
    private Event event;
}
