package com.example.conferenceorganizerbackend;

import lombok.Getter;

@Getter
public class ExistingEmailException extends Exception {

    private String message = "User with email already exist";

    public ExistingEmailException() {
        super();
    }

}
