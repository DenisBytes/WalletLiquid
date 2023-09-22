package com.denis.portfoliospringporject.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Range;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;

@Entity
@Table(name = "transactions")
public class Transaction {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "`order`")
    private String order;

    @NotBlank(message = "{NotBlank.transaction.direction}")
    private String direction;

    @NotBlank(message = "{NotBlank.transaction.symbol}")
    private String symbol;

    @NotNull(message = "{NotNull.transaction.leverage}")
    private int leverage;

    @NotNull(message = "{NotNull.transaction.price}")
    private double price;

    private double lastPrice;

    private double earnings;

    @NotNull(message = "{NotNull.transaction.amount}")
    @Range(min = 1, message = "{Range.transaction.amount}")
    private double amount;

    @NotNull(message = "{NotNull.transaction.tokenSize}")
    @Column(name = "token_size")
    private double tokenSize;

    @NotNull(message = "{NotNull.transaction.liqPrice}")
    @Column(name = "liquidation_price")
    private double liqPrice;

    @Column(name = "created_at",updatable=false)
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createdAt;

    @Column(name = "closed_at",updatable=false)
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime closedAt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne (fetch = FetchType.LAZY)
    @JoinColumn (name = "type_id")
    public Type type;

    public Transaction(){

    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getOrder() {
        return order;
    }

    public void setOrder(String order) {
        this.order = order;
    }

    public String getDirection() {
        return direction;
    }

    public void setDirection(String direction) {
        this.direction = direction;
    }

    public int getLeverage() {
        return leverage;
    }

    public void setLeverage(int leverage) {
        this.leverage = leverage;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public double getTokenSize() {
        return tokenSize;
    }

    public void setTokenSize(double tokenSize) {
        this.tokenSize = tokenSize;
    }
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public double getEarnings() {
        return earnings;
    }

    public void setEarnings(double earnings) {
        this.earnings = earnings;
    }

    public double getLastPrice() {
        return lastPrice;
    }

    public void setLastPrice(double lastPrice) {
        this.lastPrice = lastPrice;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public String getSymbol() {
        return symbol;
    }

    public void setSymbol(String symbol) {
        this.symbol = symbol;
    }

    public double getLiqPrice() {
        return liqPrice;
    }

    public void setLiqPrice(double liqPrice) {
        this.liqPrice = liqPrice;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    @PrePersist
    protected void onCreate(){
        this.createdAt = LocalDateTime.now();
    }

    public LocalDateTime getClosedAt() {
        return closedAt;
    }

    public void setClosedAt(LocalDateTime closedAt) {
        this.closedAt = closedAt;
    }
}
