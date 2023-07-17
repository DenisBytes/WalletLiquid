package com.denis.portfoliospringporject.services;

import com.denis.portfoliospringporject.models.Transaction;
import com.denis.portfoliospringporject.repositories.TransactionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TransactionService {
    @Autowired
    TransactionRepository transactionRepository;
    public Transaction saveTransaction(Transaction transaction){
        transaction.setTokenSize((transaction.getLeverage()*transaction.getAmount())/ transaction.getPrice());

        return transactionRepository.save(transaction);
    }

    public List<Transaction> allUserTransactionsByType(Long userId, String typeName){
        return transactionRepository.findByUserIdAndTypeName(userId,typeName);
    }

    public Transaction findTransaction(Long id){
        return transactionRepository.findById(id).orElse(null);
    }

    public List<Transaction> allUserTransactions(Long userId){
        return transactionRepository.findByUserId(userId);
    }

    public List<Transaction> allTransactionsByType(String typeName){
        return transactionRepository.findByType_Name(typeName);
    }

}
