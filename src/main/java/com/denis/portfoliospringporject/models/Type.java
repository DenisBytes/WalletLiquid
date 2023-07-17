package com.denis.portfoliospringporject.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;

import java.util.List;

@Entity
@Table(name = "types")
public class Type {
    @Id
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    public Long id;

    @NotBlank
    public String name;

    @OneToMany(mappedBy = "type",fetch = FetchType.LAZY)
    public List<Transaction> transactions;

    public Type(){

    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<Transaction> getTransactions() {
        return transactions;
    }

    public void setTransactions(List<Transaction> transactions) {
        this.transactions = transactions;
    }
}
