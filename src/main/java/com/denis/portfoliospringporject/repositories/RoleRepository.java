package com.denis.portfoliospringporject.repositories;

import com.denis.portfoliospringporject.models.Role;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RoleRepository extends CrudRepository<Role, Long> {
    List<Role> findAll();
    List<Role> findByName(String name);
}