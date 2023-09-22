package com.denis.portfoliospringporject.models;


import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import org.springframework.format.annotation.DateTimeFormat;

import java.text.DecimalFormat;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

@Entity
@Table(name="users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "{NotBlank.user.firstName}")
    @Size(min=3, max=30, message = "{Size.user.firstName}")
    private String firstName;

    @NotBlank(message = "{NotBlank.user.lastName}")
    @Size(min=3, max=30, message = "{Size.user.lastName}")
    private String lastName;

    @Column(unique = true)
    @NotBlank(message = "{NotBlank.user.email}")
    @Size(min=5, message = "{Size.user.email}")
    private String email;

    private double usd = 100000;

    @NotNull
    private String image = "/images/pfp.png";

    @NotBlank(message = "{NotBlank.user.password}")
    @Size(min=5, message = "{Size.user.password}")
    @Pattern(regexp="^(?=.*[A-Z])(?=.*\\d).*$", message="{Pattern.user.password}")
    private String password;

    @Transient
    private String confirm;

    @Column(name = "created_at",updatable=false)
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createdAt;

    @Column(name = "updated_at",updatable=false)
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updatedAt;

    @Column(name = "last_login")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime lastLogin;

    @OneToMany(mappedBy = "user",fetch = FetchType.LAZY)
    private List<Transaction> transactions;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
            name = "users_roles",
            joinColumns = @JoinColumn(name = "user_id"),
            inverseJoinColumns = @JoinColumn(name = "role_id"))
    private List<Role> roles;


    public User() {}

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getConfirm() {
        return confirm;
    }

    public void setConfirm(String confirm) {
        this.confirm = confirm;
    }

    public List<Transaction> getTransactions() {
        return transactions;
    }

    public void setTransactions(List<Transaction> transactions) {
        this.transactions = transactions;
    }

    public double getUsd() {
        return usd;
    }

    public void setUsd(double usd) {
        DecimalFormat decimalFormat = new DecimalFormat("#.##");
        this.usd = Double.parseDouble(decimalFormat.format(usd));
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public LocalDateTime getLastLogin() {
        return lastLogin;
    }

    public void setLastLogin(LocalDateTime dateTime) {
        this.lastLogin = dateTime;
    }

    @PrePersist
    protected void onCreate(){
        this.createdAt = LocalDateTime.now();
    }

    @PreUpdate
    public void updateOn(){
        this.updatedAt = LocalDateTime.now();
    }

    public List<Role> getRoles() {
        return roles;
    }

    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }
}