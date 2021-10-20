package com.example.conferenceorganizerbackend.compositekey;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Embeddable
public class PersonEventKey implements Serializable {

    @Column(name = "person_id")
    private Integer personId;

    @Column(name = "event_id")
    private Integer eventId;
}
