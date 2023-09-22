package com.denis.portfoliospringporject.repositories;

import com.denis.portfoliospringporject.models.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends CrudRepository<User, Long> {
    List<User> findAll();
    User findByEmail(String email);
    List<User> findAllByOrderByUsdDesc();

    boolean existsByEmail(String email);

}