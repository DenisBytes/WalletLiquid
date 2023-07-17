package com.denis.portfoliospringporject.services;

import com.denis.portfoliospringporject.models.Type;
import com.denis.portfoliospringporject.repositories.TypeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TypeService {
    @Autowired
    TypeRepository typeRepository;

    public void saveType(Type type){
        typeRepository.save(type);
    }

    public Type findByName(String name){
        return typeRepository.findByName(name);
    }
}
