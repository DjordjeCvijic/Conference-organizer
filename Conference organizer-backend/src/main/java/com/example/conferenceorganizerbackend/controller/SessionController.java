package com.example.conferenceorganizerbackend.controller;

import com.example.conferenceorganizerbackend.dto.SessionEventInfoDto;
import com.example.conferenceorganizerbackend.dto.SessionToEditDto;
import com.example.conferenceorganizerbackend.services.SessionService;
import javassist.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/session")
public class SessionController {
    @Autowired
    private SessionService sessionService;

    @PostMapping("/get-session-to-edit")
    public SessionToEditDto getSessionToEdit(@RequestBody int sessionId) throws NotFoundException {
        return sessionService.getSessionToEdit(sessionId);
    }
}
