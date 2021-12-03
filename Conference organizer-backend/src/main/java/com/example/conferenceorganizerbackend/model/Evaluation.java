package com.example.conferenceorganizerbackend.model;


import com.example.conferenceorganizerbackend.compositekey.EvaluationKey;
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
@Table(name = "evaluation")
public class Evaluation {

    @EmbeddedId
    @Column(name = "evaluation_key")
    EvaluationKey evaluationKey;

    @ManyToOne
    @MapsId("personId")//kako se zove u veznoj tabel//mora se poklapati kao u kljucu
    @JoinColumn(name = "user_id", nullable = false)//kako se zove u ovoj
    @JsonIgnore
    private Person person;


    @ManyToOne
    @MapsId("gradingSubjectId")
    @JoinColumn(name = "grading_subject_id", nullable = false)
    private GradingSubject gradingSubject;

    @Column(name = "grade",nullable = false)
    private Integer grade;

}
