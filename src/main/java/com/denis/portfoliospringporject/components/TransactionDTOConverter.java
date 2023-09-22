package com.denis.portfoliospringporject.components;

import com.denis.portfoliospringporject.dto.TransactionDTO;
import com.denis.portfoliospringporject.models.Transaction;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class TransactionDTOConverter {
    public TransactionDTO entityToDto(Transaction transaction){
        TransactionDTO dto = new TransactionDTO();
        dto.setOrder(transaction.getOrder());
        dto.setDirection(transaction.getDirection());
        dto.setLeverage(transaction.getLeverage());
        dto.setPrice(transaction.getPrice());
        dto.setLastPrice(transaction.getLastPrice());
        dto.setEarnings(transaction.getEarnings());
        dto.setAmount(transaction.getAmount());
        dto.setTokenSize(transaction.getTokenSize());
        dto.setLiqPrice(transaction.getLiqPrice());
        dto.setSymbol(transaction.getSymbol());
        dto.setCreatedAt(transaction.getCreatedAt());
        dto.setUser(transaction.getUser());
        dto.setType(transaction.getType());

        return dto;
    }

    public List<TransactionDTO> entityToDtoList(List<Transaction> transactions) {
        List<TransactionDTO> dtoList = new ArrayList<>();
        for (Transaction transaction : transactions) {
            dtoList.add(entityToDto(transaction));
        }
        return dtoList;
    }

}
