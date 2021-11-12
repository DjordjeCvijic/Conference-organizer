package com.example.conferenceorganizerbackend.services;

import com.example.conferenceorganizerbackend.dto.ConferenceInfoDto;
import com.example.conferenceorganizerbackend.dto.ConferenceRequestDto;
import com.example.conferenceorganizerbackend.dto.ConferenceToShowDto;
import com.example.conferenceorganizerbackend.model.Conference;
import com.example.conferenceorganizerbackend.model.GradingSubject;
import com.example.conferenceorganizerbackend.model.Session;
import com.example.conferenceorganizerbackend.repository.ConferenceRepository;
import javassist.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.LinkedList;
import java.util.List;

@Service
public class ConferenceService {

    @Autowired
    private ConferenceRepository conferenceRepository;
    @Autowired
    private LocationService locationService;
    @Autowired
    private PersonService personService;
    @Autowired
    private GradingSubjectService gradingSubjectService;
    @Autowired
    private SessionService sessionService;

    public Conference getById(int id) throws NotFoundException {
        return conferenceRepository.findById(id)
                .orElseThrow(() -> new NotFoundException("Nije pronađen sadržaj sa id-em:" + id));
    }

    public List<ConferenceInfoDto> getAll() {
        List<ConferenceInfoDto> res = new LinkedList<>();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd.MM.yyyy");

        List<Conference> conferenceList = conferenceRepository.findAll();
        conferenceList.forEach(e -> res.add(new ConferenceInfoDto(e.getConference_id(), e.getName(), e.getDateFrom().format(formatter), e.getDateTo().format(formatter), e.getLocation().getName(), e.getCreator().getEmail())));
        return res;
    }

    public Conference save(ConferenceRequestDto conferenceRequestDto) throws NotFoundException {
        Conference savedConference = conferenceRepository.save(buildConferenceFromDto(conferenceRequestDto));
        //treba sacuvati grading subject
        conferenceRequestDto.getGradingSubjectList().forEach(e -> gradingSubjectService.save(
                new GradingSubject(0, e, savedConference)));


        //treba sacuvati session
        conferenceRequestDto.getSessionRequestDtoList().forEach(
                element -> sessionService.saveSession(new Session(0, element.getName(), element.getDescription(), element.isOnline(), savedConference, personService.getPersonByEmail(element.getModeratorEmail()))));

        return savedConference;
    }

    private Conference buildConferenceFromDto(ConferenceRequestDto conferenceRequestDto) throws NotFoundException {
        Conference result = new Conference();
        result.setName(conferenceRequestDto.getName());
        result.setDescription(conferenceRequestDto.getDescription());
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        result.setDateFrom(LocalDateTime.parse(conferenceRequestDto.getDateFrom().substring(0, 16), formatter));
        result.setDateTo(LocalDateTime.parse(conferenceRequestDto.getDateTo().substring(0, 16), formatter));
        result.setLocation(locationService.getById(conferenceRequestDto.getLocationId()));
        result.setCreator(personService.getById(conferenceRequestDto.getCreatorId()));
        return result;
    }

    public ConferenceToShowDto getConferenceToShow(Integer conferenceId) {
        ConferenceToShowDto result=new ConferenceToShowDto();
        Conference conference= conferenceRepository.getById(conferenceId);
        result.setName(conference.getName());
        result.setConferenceId(conferenceId);
        result.setDescription(conference.getDescription());
        result.setDateFrom(conference.getDateFrom().toString());
        result.setDateTo(conference.getDateTo().toString());
        result.setLocation(conference.getLocation().getName());
        result.setCreatorEmail(conference.getCreator().getEmail());

        //sessionService.getAllSessionByConference(conference).forEach(e->result.addSessionOnList(e.getSession_id(),e.getName()));


        return result;
    }
}
