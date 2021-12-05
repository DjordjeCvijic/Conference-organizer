package com.example.conferenceorganizerbackend.services;

import com.example.conferenceorganizerbackend.compositekey.PersonEventKey;
import com.example.conferenceorganizerbackend.dto.UserEventDto;
import com.example.conferenceorganizerbackend.model.Event;
import com.example.conferenceorganizerbackend.model.Person;
import com.example.conferenceorganizerbackend.model.PersonEvent;
import com.example.conferenceorganizerbackend.repository.PersonEventRepository;
import javassist.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.LinkedList;
import java.util.List;

@Service
public class PersonEventService {
    @Autowired
    private PersonEventRepository personEventRepository;
    @Autowired
    private PersonService personService;
    @Autowired
    private EventService eventService;

    public boolean isSubscribed(UserEventDto userEventDto) throws NotFoundException {
        System.out.println("user "+userEventDto.getUserId()+ " evemt "+userEventDto.getEventId());
        if( personEventRepository.existsById(new PersonEventKey(userEventDto.getUserId(), userEventDto.getEventId())))return  true;
         throw new NotFoundException("nije prijavljen");
    }

    public void subscribe(UserEventDto userEventDto) throws NotFoundException {
        if( personEventRepository.existsById(new PersonEventKey(userEventDto.getUserId(), userEventDto.getEventId())))
            personEventRepository.deleteById(new PersonEventKey(userEventDto.getUserId(), userEventDto.getEventId()));
        else
            personEventRepository.save(new PersonEvent(new PersonEventKey(userEventDto.getUserId(), userEventDto.getEventId()),personService.getById(userEventDto.getUserId()),eventService.getById(userEventDto.getEventId())));

    }
    public List<Event> getEventsOfPersonSubscribedOn(Person person){
        List<PersonEvent>personEventList=personEventRepository.findAllByPerson(person);
        List<Event>res=new LinkedList<>();
        personEventList.forEach(e->res.add(e.getEvent()));
        return res;
    }

}
