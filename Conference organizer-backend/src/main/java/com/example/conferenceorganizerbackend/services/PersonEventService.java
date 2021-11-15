package com.example.conferenceorganizerbackend.services;

import com.example.conferenceorganizerbackend.compositekey.PersonEventKey;
import com.example.conferenceorganizerbackend.dto.UserEventDto;
import com.example.conferenceorganizerbackend.model.PersonEvent;
import com.example.conferenceorganizerbackend.repository.PersonEventRepository;
import javassist.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PersonEventService {
    @Autowired
    private PersonEventRepository personEventRepository;
    @Autowired
    private PersonService personService;
    @Autowired
    private EventService eventService;

    public boolean isSubscribed(UserEventDto userEventDto) throws NotFoundException {

        if( personEventRepository.existsById(new PersonEventKey(userEventDto.getUserId(), userEventDto.getEventId())))return  true;
         throw new NotFoundException("nije prijavljen");
    }

    public void subscribe(UserEventDto userEventDto) throws NotFoundException {
        if( personEventRepository.existsById(new PersonEventKey(userEventDto.getUserId(), userEventDto.getEventId())))
            personEventRepository.deleteById(new PersonEventKey(userEventDto.getUserId(), userEventDto.getEventId()));
        else
            personEventRepository.save(new PersonEvent(new PersonEventKey(userEventDto.getUserId(), userEventDto.getEventId()),personService.getById(userEventDto.getUserId()),eventService.getById(userEventDto.getEventId())));

    }
}
