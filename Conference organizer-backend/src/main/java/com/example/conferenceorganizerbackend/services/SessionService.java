package com.example.conferenceorganizerbackend.services;

import com.example.conferenceorganizerbackend.dto.EventDto;
import com.example.conferenceorganizerbackend.dto.SessionToEditDto;
import com.example.conferenceorganizerbackend.model.Event;
import com.example.conferenceorganizerbackend.model.Session;
import com.example.conferenceorganizerbackend.repository.SessionRepository;
import javassist.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.LinkedList;
import java.util.List;

@Service
public class SessionService {

    @Autowired
    private SessionRepository sessionRepository;
    @Autowired
    private PersonService personService;

    @Autowired
    private EventService eventService;

    @Autowired
    private PlaceService placeService;
    @Autowired
    private EventTypeService eventTypeService;


    public Session saveSession(Session sessionToSave){
        return sessionRepository.save(sessionToSave);
    }

    public List<Session> getMySessionsForSupervision(String email) {
        return sessionRepository.findAllByModerator(personService.getPersonByEmail(email));
    }

    public SessionToEditDto getSessionToEdit(int sessionId) throws NotFoundException {
        Session session=sessionRepository.findById(sessionId).orElseThrow(()-> new NotFoundException("ne postoji trazen asesija"));
        SessionToEditDto result=new SessionToEditDto();
        result.setSessionId(session.getSession_id());
        result.setName(session.getName());
        result.setDescription(session.getDescription());
        result.setLocationId(session.getConference().getLocation().getLocationId());

        DateTimeFormatter formatterForDay = DateTimeFormatter.ofPattern("dd.MM.yyyy");
        DateTimeFormatter formatterForTime = DateTimeFormatter.ofPattern("hh:mm");

        List<Event> eventList=eventService.getEventsOfSession(session);
        eventList.forEach(e->result.addEvent(new EventDto(e.getEventId(),e.getName(),e.getDescription(),e.getDate().format(formatterForDay),e.getTimeFrom().format(formatterForTime),e.getTimeTo().format(formatterForTime),e.getModerator().getEmail(),e.getPlace().getPlaceId(),e.getEventType().getEventTypeId(),session.getSession_id())));

        return result;
    }

    public Session saveEditedSession(SessionToEditDto sessionToEditDto) {
        Session sessionToSave=sessionRepository.getById(sessionToEditDto.getSessionId());
        sessionToSave.setName(sessionToEditDto.getName());
        sessionToSave.setDescription(sessionToEditDto.getDescription());

        List<Event>eventList=new LinkedList<>() ;
        sessionToEditDto.getEventList().forEach(e->eventList.add(new Event(0,e.getName(),e.getDescription(), LocalDateTime.parse(e.getDate()),LocalDateTime.parse(e.getTimeFrom()),LocalDateTime.parse(e.getTimeTo()),"","",null,personService.getPersonByEmail(e.getModeratorEmail()),placeService.getById(e.getPlaceId()),eventTypeService.getById(e.getEventTypeId()),sessionToSave)));

        eventList.forEach(e->eventService.save(e));

        return sessionRepository.save(sessionToSave);

    }
}
