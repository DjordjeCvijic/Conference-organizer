package com.example.conferenceorganizerbackend.services;

import com.example.conferenceorganizerbackend.dto.ConferenceInfoDto;
import com.example.conferenceorganizerbackend.model.Conference;
import com.example.conferenceorganizerbackend.repository.ConferenceRepository;
import javassist.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.LinkedList;
import java.util.List;

@Service
public class ConferenceService {

    @Autowired
    private ConferenceRepository conferenceRepository;

    public Conference findById(int id) throws NotFoundException {
        return conferenceRepository.findById(id)
                .orElseThrow(() -> new NotFoundException("Nije pronađen sadržaj sa id-em:" + id));
    }

    public List<ConferenceInfoDto> getAll() {
        List<ConferenceInfoDto> res=new LinkedList<>();
        res.add(new ConferenceInfoDto(1,"konferencija 1","20.04.2020","25.04.2020","lokavcija 1","kreator@mail"));
        res.add(new ConferenceInfoDto(2,"konferencija 2","20.04.2020","25.04.2020","lokavcija 1","kreator@mail"));
        res.add(new ConferenceInfoDto(3,"konferencija 3","20.04.2020","25.04.2020","lokavcija 1","kreator@mail"));
        res.add(new ConferenceInfoDto(4,"konferencija 4","20.04.2020","25.04.2020","lokavcija 1","kreator@mail"));
        res.add(new ConferenceInfoDto(5,"konferencija 5","20.04.2020","25.04.2020","lokavcija 1","kreator@mail"));
        res.add(new ConferenceInfoDto(6,"konferencija 7","20.04.2020","25.04.2020","lokavcija 1","kreator@mail"));
        res.add(new ConferenceInfoDto(7,"konferencija 7","20.04.2020","25.04.2020","lokavcija 1","kreator@mail"));
        res.add(new ConferenceInfoDto(8,"konferencija 8","20.04.2020","25.04.2020","lokavcija 1","kreator@mail"));

        return res;
    }
}
