package com.example.conferenceorganizerbackend.services;

import com.example.conferenceorganizerbackend.dto.GradingSubjectDto;
import com.example.conferenceorganizerbackend.dto.PersonConferenceDto;
import com.example.conferenceorganizerbackend.model.Evaluation;
import com.example.conferenceorganizerbackend.model.GradingSubject;
import com.example.conferenceorganizerbackend.repository.GradingSubjectRepository;
import io.swagger.v3.oas.models.links.Link;
import javassist.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.LinkedList;
import java.util.List;

@Service
public class GradingSubjectService {

    @Autowired
    private GradingSubjectRepository gradingSubjectRepository;
    @Autowired
    private ConferenceService conferenceService;
    @Autowired
    private EvaluationService evaluationService;

    public GradingSubject save(GradingSubject gradingSubjectToSave){
        return gradingSubjectRepository.save(gradingSubjectToSave);
    }

    public List<GradingSubjectDto> getAllForConference(Integer conferenceId) throws NotFoundException {
        List<GradingSubject> gradingSubjectList=gradingSubjectRepository.findAllByConference(conferenceService.getById(conferenceId));
        List<GradingSubjectDto> result=new LinkedList<>();

        gradingSubjectList.forEach(e->result.add(new GradingSubjectDto(e.getGradingSubjectId(),e.getName(),0.0)));
        return result;
    }

    public boolean isGradingDone(PersonConferenceDto personConferenceDto) throws NotFoundException {

        List<Evaluation>evaluationList=evaluationService.getEvaluationByPerson(personConferenceDto.getPersonId());
        if(evaluationList.size()!=0){
            for(Evaluation evaluation : evaluationList){
                if(evaluation.getGradingSubject().getConference().getConference_id().intValue()== personConferenceDto.getConferenceId().intValue())
                    return true;
            }
        }

        return false;
    }
    public GradingSubject getById(Integer id) throws NotFoundException {
        return gradingSubjectRepository.findById(id).orElseThrow(()->new NotFoundException("nema"));
    }
}
