package com.example.conferenceorganizerbackend.services;

import com.example.conferenceorganizerbackend.compositekey.EvaluationKey;
import com.example.conferenceorganizerbackend.dto.GradesFromPersonDto;
import com.example.conferenceorganizerbackend.dto.GradingSubjectDto;
import com.example.conferenceorganizerbackend.model.Evaluation;
import com.example.conferenceorganizerbackend.model.GradingSubject;
import com.example.conferenceorganizerbackend.model.Person;
import com.example.conferenceorganizerbackend.repository.EvaluationRepository;
import javassist.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EvaluationService {
    @Autowired
    private EvaluationRepository evaluationRepository;
    @Autowired
    private PersonService personService;
    @Autowired
    private GradingSubjectService gradingSubjectService;


    public List<Evaluation> getEvaluationByPerson(Integer  personID) throws NotFoundException {
        return evaluationRepository.findAllByPerson(personService.getById(personID));
    }


    public void saveGrades(GradesFromPersonDto gradesFromPersonDto) throws NotFoundException {
        for(GradingSubjectDto g:gradesFromPersonDto.getGrades()){
            Evaluation evaluation=new Evaluation(new EvaluationKey(gradesFromPersonDto.getPersonId(),g.getGradingSubjectId()),personService.getById(gradesFromPersonDto.getPersonId()),gradingSubjectService.getById(g.getGradingSubjectId()),g.getGrade().intValue());
            evaluationRepository.save(evaluation);
        }
    }

    public List<GradingSubjectDto> getAllForConference(Integer conferenceId) throws NotFoundException {
        List<GradingSubjectDto> gradingSubjects=gradingSubjectService.getAllForConference(conferenceId);
        for (GradingSubjectDto gradingSubject:gradingSubjects){
            List<Evaluation>evaluationList=evaluationRepository.findAllByEvaluationKeyGradingSubjectId(gradingSubject.getGradingSubjectId());
            for(Evaluation e:evaluationList){
                gradingSubject.setGrade(gradingSubject.getGrade()+e.getGrade());
            }

            if(gradingSubject.getGrade()!=0.0)
                gradingSubject.setGrade(Math.round((gradingSubject.getGrade()/evaluationList.size())*100.0)/100.0);

        }



        return gradingSubjects;
    }
}
