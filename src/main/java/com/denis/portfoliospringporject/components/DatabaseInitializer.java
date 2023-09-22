package com.denis.portfoliospringporject.components;

import org.springframework.stereotype.Component;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.annotation.PostConstruct;


@Component
public class DatabaseInitializer {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @PostConstruct
    public void executeQueryOnStart() {

        String query1 = "INSERT IGNORE INTO types (id,name) VALUES (1,'open')";
        String query2 = "INSERT IGNORE INTO types (id,name) VALUES (2,'closed')";
        String query3 = "INSERT IGNORE INTO types (id,name) VALUES (3,'pending')";
        String query4 = "INSERT IGNORE INTO roles (id,name) values (1,'ROLE_USER')";
        String query5 = "INSERT IGNORE INTO roles (id,name) values (2,'ROLE_ADMIN')";
        String query6 = "INSERT IGNORE INTO roles (id,name) values (3,'ROLE_SUPER_ADMIN')";

        jdbcTemplate.execute(query1);
        jdbcTemplate.execute(query2);
        jdbcTemplate.execute(query3);
        jdbcTemplate.execute(query4);
        jdbcTemplate.execute(query5);
        jdbcTemplate.execute(query6);

    }
}