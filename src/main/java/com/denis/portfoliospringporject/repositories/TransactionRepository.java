package com.denis.portfoliospringporject.repositories;

import com.denis.portfoliospringporject.models.Transaction;
import com.denis.portfoliospringporject.models.User;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TransactionRepository extends CrudRepository<Transaction, Long> {
    List<Transaction> findAll();

    @Query("SELECT t FROM Transaction t WHERE t.user.id = :userId AND t.type.name = :typeName")
    List<Transaction> findByUserIdAndTypeName(Long userId, String typeName);

    List<Transaction> findByUserId(Long userId);
}
