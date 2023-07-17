package com.denis.portfoliospringporject.repositories;

import com.denis.portfoliospringporject.models.Type;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TypeRepository extends CrudRepository<Type, Long> {
    List<Type> findAll();
    Type findByName(String string);
}
