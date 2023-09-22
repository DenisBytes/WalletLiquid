package com.denis.portfoliospringporject.dto;

import com.denis.portfoliospringporject.models.Type;
import com.denis.portfoliospringporject.models.User;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.validator.constraints.Range;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
public class TransactionDTO {
    private Long id;
    private String order;

    @NotBlank(message = "Long or short is required!")
    private String direction;

    @NotBlank(message = "Select a token to trade please!")
    private String symbol;

    @NotNull(message = "Leverage is required!")
    private int leverage;

    @NotNull(message = "Current Price is Required! Try again.")
    private double price;

    private double lastPrice;
    private double earnings;

    @NotNull(message = "Amount is required!")
    @Range(min = 1, message = "Amount has to be minimum 1 usd and not bigger than your portfolio")
    private double amount;

    @NotNull(message = "Token size is required!")
    private double tokenSize;

    @NotNull(message = "Liquidation Price is required!")
    private double liqPrice;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createdAt;

    private User user;

    public Type type;
}
