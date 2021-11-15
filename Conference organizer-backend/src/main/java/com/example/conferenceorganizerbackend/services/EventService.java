package com.example.conferenceorganizerbackend.services;

import com.example.conferenceorganizerbackend.compositekey.EventResourceKey;
import com.example.conferenceorganizerbackend.dto.EventToEditDto;
import com.example.conferenceorganizerbackend.dto.EventToShowDto;
import com.example.conferenceorganizerbackend.dto.SessionToShowDto;
import com.example.conferenceorganizerbackend.dto.UserEventDto;
import com.example.conferenceorganizerbackend.model.Event;
import com.example.conferenceorganizerbackend.model.EventResource;
import com.example.conferenceorganizerbackend.model.Session;
import com.example.conferenceorganizerbackend.repository.EventRepository;
import javassist.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.LinkedList;
import java.util.List;

@Service
public class EventService {

    @Autowired
    private EventRepository eventRepository;
    @Autowired
    private PersonService personService;
@Autowired
private ResourceService resourceService;
    @Autowired
    private EventResourceService eventResourceService;
    @Autowired
    private SessionService sessionService;

    public List<Event> getMyEventsForSupervision(String email) {
        return eventRepository.findAllByModerator(personService.getPersonByEmail(email));
    }


    public List<Event> getEventsOfSession(Session session){
        return eventRepository.findAllBySession(session);
    }


    public Event save(Event event){
        return eventRepository.save(event);
    }

    public EventToEditDto getEventToEditDtoById(int id) throws NotFoundException {
        Event event= eventRepository.findById(id).orElseThrow(()->new NotFoundException("Ne postoji event sa id "+id));
        EventToEditDto result=new EventToEditDto();
        result.setEventId(event.getEventId());
        result.setName(event.getName());
        result.setDescription(event.getDescription());
        result.setLecturerEmail(event.getLecturer()!=null?event.getLecturer().getEmail():"");
        result.setIsOnline(event.getSession().getIsOnline());
        result.setAccessLink(event.getAccessLink());
        result.setAccessPassword(event.getAccessPassword());

        List<EventResource> resourceList=eventResourceService.getAllBuEvent(event);
        resourceList.forEach(e->result.addResourceId(e.getResource().getResourceId()));

        return  result;
    }

    public Event saveEventDto(EventToEditDto eventToEditDto) {
        Event eventToUpdate=eventRepository.findById(eventToEditDto.getEventId()).get();
        eventToUpdate.setName(eventToEditDto.getName());
        eventToUpdate.setDescription(eventToEditDto.getDescription());
        eventToUpdate.setLecturer(personService.getPersonByEmail(eventToEditDto.getLecturerEmail()));
        eventToUpdate.setAccessLink(eventToEditDto.getAccessLink());
        eventToUpdate.setAccessPassword(eventToEditDto.getAccessPassword());

        eventToEditDto.getResourceIdList().forEach(e-> {
            try {
                eventResourceService.save(new EventResource(new EventResourceKey(eventToUpdate.getEventId(),e),eventToUpdate,resourceService.getById(e)));
            } catch (NotFoundException ex) {
                ex.printStackTrace();
            }
        });

        return save(eventToUpdate);
    }

    public List<EventToShowDto> getAllEventToShow(Integer sessionId) {
        List<EventToShowDto> res=new LinkedList<>();
        List<Event>eventList=eventRepository.findAllBySession(sessionService.getSessionById(sessionId));

        for(int i=0;i<eventList.size();i++){
            Event e=eventList.get(i);
            EventToShowDto dto=new EventToShowDto();
            dto.setEventId(e.getEventId());
            dto.setName(e.getName());
            dto.setDescription(e.getDescription());
            dto.setDate(e.getDate().toString());
            dto.setTimeFrom(e.getTimeFrom().toString());
            dto.setTimeTo(e.getTimeTo().toString());
            dto.setPlace(e.getPlace().getName());
            dto.setAccessLink(e.getAccessLink());
            dto.setAccessPassword(e.getAccessPassword());
            dto.setOnline(e.getSession().getIsOnline());
            dto.setLecturerEmail(e.getLecturer().getEmail());
            dto.setEventType(e.getEventType().getName());

            res.add(dto);
        }


        return res;
    }

    public Event getById(Integer eventId) throws NotFoundException {
        return eventRepository.findById(eventId).orElseThrow(()->new NotFoundException("nema eventa"));
    }


}
